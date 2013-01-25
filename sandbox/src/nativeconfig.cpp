#include <cstdio>
#include <sstream>
#include <cmath>
#include <sys/wait.h>
#include <sys/resource.h>
#include <sys/ptrace.h>
#include "nativeconfig.h"
#include "syscallshandler.h"

bool NativeConfig::setLimits() {
    struct rlimit rls;

    if (timeLimit > 0) {
        rls.rlim_cur = rls.rlim_max = (long) ceil(timeLimit + extraTime);
        if (setrlimit(RLIMIT_CPU, &rls) != 0) {
            errorString = "setrlimit(RLIMIT_CPU) failed!";
            return false;
        }
    }

    if (memoryLimit > 0) {
        rls.rlim_cur = rls.rlim_max = (memoryLimit + extraMemory) * 1024;
        if (setrlimit(RLIMIT_AS, &rls) != 0) {
            errorString = "setrlimit(RLIMIT_AS) failed!";
            return false;
        }
    }

    if (disableThreads) {
        rls.rlim_cur = rls.rlim_max = 0;
        if (setrlimit(RLIMIT_NPROC, &rls) != 0) {
            errorString = "setrlimit(RLIMIT_NPROC) failed!";
            return false;
        }
    }

    return true;
}

void NativeConfig::exec() {

    int argc = commandVector.size() + 1;
    const char * arguments[argc];
    for (std::vector<std::string>::iterator it = commandVector.begin(); it != commandVector.end(); ++it) {
        arguments[it - commandVector.begin()] = it->c_str();
    }
    arguments[argc - 1] = NULL;

    ptrace(PTRACE_TRACEME, 0, 0, 0);
    execvp((const char*) arguments[0], (char * const *) arguments);
}

int NativeConfig::handle(int childPid) {
    SyscallsHandler handler(childPid, readAllowedFiles,
            writeAllowedFiles, blockSyscalls, blockFiles);
    int processStatus;
    SyscallsHandler::HandlerResponse handleResult = SyscallsHandler::respOk;

    while (handleResult == SyscallsHandler::respOk) {
        //usleep(1000);
        //int r = waitpid(childPid, &processStatus, WNOHANG);
        int r = waitpid(childPid, &processStatus, 0);

        if ((r > 0) && (WIFEXITED(processStatus) || WIFSIGNALED(processStatus))) break;
        //if (r == -1) continue;
        if (WIFSTOPPED(processStatus)) {
            int sig = WSTOPSIG(processStatus);
            if (sig == SIGTRAP) {
                handler.grabRegs();
                if (handler.getRegs().orig_r1 >= 0) {
                    handleResult = handler.handleSecurity();
                    if (handleResult != SyscallsHandler::respOk) {
                        kill(childPid, SIGKILL);
                        errorString = handler.getErrorString();
                    }
                    ptrace(PTRACE_SYSCALL, childPid, 0, 0);
                }
            } else {
                ptrace(PTRACE_SYSCALL, childPid, 0, sig);
            }
        }
    }
    return processStatus;
}
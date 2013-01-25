
#include "syscallshandler.h"
#include <cstdio>
#include <set>

SyscallsHandler::HandlerResponse SyscallsHandler::handleSecurity() {
    
    if(!blockSyscalls) return respOk;

    int syscallNo = getRegs().orig_r1;
    //printf("State %d Syscall %d (%s)\n", state, syscallNo, getSyscallName(syscallNo));

#ifdef __x86_64__
    switch (state) {
        case stStart:
            if (syscallNo == __NR_execve) {
                state = stInit;
            } else {
                state = stError;
            }
            break;

        case stInit:
            switch (syscallNo) {
                    //case __NR_sigaction:
                case __NR_rt_sigaction:
                case __NR_sigaltstack:
                case __NR_uname:
                case __NR_getpid:
                case __NR_getuid:
                    //case __NR_getuid32:
                case __NR_getgid:
                case __NR_geteuid:
                case __NR_getegid:
                    break;

                default:
                    state = stRun;
                    break;
            }

            if (state != stRun) break;

        case stRun:
            switch (syscallNo) {
                case __NR_exit:
                case __NR_exit_group:
                    state = stOk;
                    break;

                    
                case __NR_rt_sigprocmask:
                case __NR_gettid:
                case __NR_tgkill:
                case -1:
                case __NR_restart_syscall:
                case __NR_getpid:
                case __NR_getuid:
                    //case __NR_getuid32:
                case __NR_getgid:
                case __NR_geteuid:
                case __NR_getegid:
                    //case __NR_olduname:
                case __NR_uname:
                case __NR_mmap:
                    //case __NR_mmap2:
                case __NR_munmap:
                case __NR_brk:
                case __NR_mremap:
                case __NR_time:
                case __NR_times:
                case __NR_gettimeofday:
                case __NR_arch_prctl:
                    break;

                case __NR_open:
                case __NR_creat:
                    if (!allowedOpen()) {
                        std::stringstream error;
                        error << "child process opened/created forbidden file " << lastFileName;
                        error << " in mode " << resolveFileMode(lastFileMode);
                        errorString = error.str();
                        state = stBlockedFile;
                    }
                    break;

                case __NR_read:
                case __NR_readv:
                    if (!allowedRead()) {
                        errorString = "child process read from forbidden file";
                        state = stBlockedFile;
                    }
                    break;
                    break;

                case __NR_write:
                case __NR_writev:
                    if (!allowedWrite()) {
                        errorString = "child process wrote to forbidden file";
                        state = stBlockedFile;
                    }
                    break;
                    break;

                case __NR_close:
                case __NR_lseek:
                case __NR_ioctl:
                case __NR_fcntl:
                    //case __NR_fcntl64:
                    //case __NR_oldfstat:
                case __NR_fstat:
                    //case __NR_fstat64:
                    //case __NR__llseek:
                    if (!allowedOtherIO()) {
                        errorString = "child process accessed forbidden file";
                        state = stBlockedFile;
                    }
                    break;

                    //case __NR_oldstat:
                    //case __NR_oldlstat:
                case __NR_stat:
                case __NR_lstat:
                    //case __NR_stat64:
                    //case __NR_lstat64:
                case __NR_access:
                case __NR_set_thread_area:
                    break;

                default:
                    state = stError;
                    break;
            }
            break;

        case stError:
            break;

        case stOk:
            break;
    }
#else

    switch (state) {
        case stStart:
            if (syscallNo == __NR_execve) {
                state = stInit;
            } else {
                state = stError;
            }
            break;

        case stInit:
            switch (syscallNo) {
                case __NR_sigaction:
                case __NR_sigaltstack:
                case __NR_uname:
                case __NR_getpid:
                case __NR_getuid:
                case __NR_getuid32:
                case __NR_getgid:
                case __NR_geteuid:
                case __NR_getegid:
                    break;

                default:
                    state = stRun;
                    break;
            }

            if (state != stRun) break;

        case stRun:
            switch (syscallNo) {
                case __NR_exit:
                case __NR_exit_group:
                    state = stOk;
                    break;


                case __NR_restart_syscall:
                case __NR_getpid:
                case __NR_getuid:
                case __NR_getuid32:
                case __NR_getgid:
                case __NR_geteuid:
                case __NR_getegid:
                case __NR_olduname:
                case __NR_uname:
                case __NR_mmap:
                case __NR_mmap2:
                case __NR_munmap:
                case __NR_brk:
                case __NR_mremap:
                case __NR_time:
                case __NR_times:
                case __NR_gettimeofday:
                    //
                case 258:
                case 311:
                case 174:
                case 175:
                case 191:
                case 240:
                case -1:
                    //
                    break;

                case __NR_open:
                case __NR_creat:
                    if (!allowedOpen()) {
                        std::stringstream error;
                        error << "child process opened/created forbidden file " << lastFileName;
                        error << " in mode " << resolveFileMode(lastFileMode);
                        errorString = error.str();
                        state = stBlockedFile;
                    }
                    break;

                case __NR_read:
                case __NR_readv:
                    if (!allowedRead()) {
                        errorString = "child process read from forbidden file";
                        state = stBlockedFile;
                    }
                    break;
                    break;

                case __NR_write:
                case __NR_writev:
                    if (!allowedWrite()) {
                        errorString = "child process wrote to forbidden file";
                        state = stBlockedFile;
                    }
                    break;
                    break;

                case __NR_close:
                case __NR_lseek:
                case __NR_ioctl:
                case __NR_fcntl:
                case __NR_fcntl64:
                case __NR_oldfstat:
                case __NR_fstat:
                case __NR_fstat64:
                case __NR__llseek:
                    if (!allowedOtherIO()) {
                        errorString = "child process accessed forbidden file";
                        state = stBlockedFile;
                    }
                    break;

                case __NR_oldstat:
                case __NR_oldlstat:
                case __NR_stat:
                case __NR_lstat:
                case __NR_stat64:
                case __NR_lstat64:
                case __NR_access:
                case __NR_set_thread_area:
                    break;

                default:
                    state = stError;
                    break;
            }
            break;

        case stError:
            break;

        case stOk:
            break;
    }
#endif

    if (state == stBlockedFile) {
        return respBlockedFile;
    }
    if (blockSyscalls && state == stError) {
        std::stringstream error;
        error << "child process executed forbidden syscall: ";
        error << syscallNo << " (" << getSyscallName(syscallNo) << ")";
        errorString = error.str();
        return respForbiddenSyscall;
    }
    return respOk;
}

void SyscallsHandler::getFileName(char *destination, int *length) {
    unsigned long fileNameAddress = getRegs().r2;
    destination[0] = 0;
    int i;
    for (i = 0; i < *length - 1; i++) {
        unsigned int c = ptrace(PTRACE_PEEKTEXT, pid, fileNameAddress + i, 0);
        destination[i] = c & 0xff;
        if ((c & 0xff) == 0) break;
    }
    *length = i;
}

void SyscallsHandler::grabFileDescriptor() {
   unsigned int fileDescriptor = getRegs().r1;
    readAllowedFileDescriptors.erase(fileDescriptor);
    writeAllowedFileDescriptors.erase(fileDescriptor);
    if (lastFileMode == O_RDONLY || lastFileMode == O_RDWR) {
        readAllowedFileDescriptors.insert(fileDescriptor);
    } else
        if (lastFileMode == O_WRONLY || lastFileMode == O_RDWR) {
        writeAllowedFileDescriptors.insert(fileDescriptor);
    }
}

bool SyscallsHandler::allowedOpen() {
    // ebx - filename (open, creat)
    // ecx - flags (open), mode (creat)
    // edx - mode (open)
    if (!blockFiles) return true;
    if (needFileDescriptor) {
        grabFileDescriptor();
        needFileDescriptor = false;
        lastFileName = "";
        lastFileMode = -1;
        return true;
    }
    bool allowed = false;
    char charFileName[1024];
    memset(charFileName, 0, sizeof (charFileName));
    int fileNameLength = sizeof (charFileName);
    getFileName(charFileName, &fileNameLength);
    std::string fileName = std::string(charFileName);

    //    int fileMode = ptrace(PTRACE_PEEKUSER, pid, ECXRegister, NULL);
    int fileMode = getRegs().r3;
    //printf("Child process wants to access file %s in mode %d\n", charFileName, fileMode);

    if ((fileMode & O_ACCMODE) == O_RDONLY) {
        allowed = contains(readAllowedFiles, fileName);
    } else
        if ((fileMode & O_ACCMODE) == O_WRONLY) {
        allowed = contains(writeAllowedFiles, fileName);
    } else
        if ((fileMode & O_ACCMODE) == O_RDWR) {
        allowed = contains(readAllowedFiles, fileName)
                && contains(writeAllowedFiles, fileName);
    }
    if (allowed) {
        needFileDescriptor = true;
    }
    lastFileName = fileName;
    lastFileMode = fileMode & O_ACCMODE;
    //printf("Access to file is %d\n", allowed);
    return allowed;
}

bool SyscallsHandler::allowedRead() {
    if (!blockFiles) return true;
    long fileDescriptor = getRegs().r2;
    //printf("Read from file of descriptor %ld\n", fileDescriptor);
    if (fileDescriptor >= 0 && fileDescriptor < MAX_FD) {
        return contains(readAllowedFileDescriptors, fileDescriptor);
    }
    return true;
}

bool SyscallsHandler::allowedWrite() {
    if (!blockFiles) return true;
    long fileDescriptor = getRegs().r2;
    //printf("Write to file of descriptor %ld\n", fileDescriptor);
    if (fileDescriptor >= 0 && fileDescriptor < MAX_FD) {
        return contains(writeAllowedFileDescriptors, fileDescriptor);
    }
    return true;
}

bool SyscallsHandler::allowedOtherIO() {
    if (!blockFiles) return true;
    long fileDescriptor = getRegs().r2;
    //printf("Access to file of descriptor %ld\n", fileDescriptor);
    if (fileDescriptor >= 0 && fileDescriptor < MAX_FD) {
        return contains(readAllowedFileDescriptors, fileDescriptor)
                || contains(writeAllowedFileDescriptors, fileDescriptor);
    }
    return true;
}
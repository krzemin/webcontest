/* 
 * File:   syscallshandler.h
 * Author: bazu
 *
 * Created on 9 kwiecień 2011, 13:06
 */
/*134520896
 */
#ifndef SYSCALLSHANDLER_H
#define	SYSCALLSHANDLER_H
#include <unistd.h>
#include <fcntl.h>
#include <libgen.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <sys/syscall.h>
#include <map>
#include <set>
#include <string>
#include <cstring>
#include <cstdlib>
#include <sstream>
#include <cstdio>

#ifdef __x86_64__
#include "syscalls64.h"
#define getSyscallsMap() getSyscallsMap64()
#else
#include "syscalls32.h"
#define getSyscallsMap() getSyscallsMap32()
#endif

#define MAX_FD 32768

class SyscallsHandler {
private:

    enum ProcessState {
        stStart, stInit, stRun, stError, stBlockedFile, stOk
    };

    struct registers {
#ifdef __x86_64__
        unsigned long orig_r1, r1, r2, r3, r4;
#else
        long int orig_r1, r1, r2, r3, r4;
#endif  
    };

    ProcessState state;
    int pid;
    long ORIGEAXRegister;
    long EAXRegister;
    long EBXRegister;
    long ECXRegister;
    long EDXRegister;
    struct registers regs;
    bool blockFiles;
    bool blockSyscalls;
    bool needFileDescriptor;
    bool lastFileMode;
    std::string lastFileName;
    unsigned int lastFileDescriptor;
    std::set<std::string> writeAllowedFiles;
    std::set<std::string> readAllowedFiles;
    std::set<long> readAllowedFileDescriptors;
    std::set<long> writeAllowedFileDescriptors;
    std::string errorString;
    std::map<int,std::string> syscallsMap;
    bool allowedOpen();
    bool allowedWrite();
    bool allowedRead();
    bool allowedOtherIO();
    void grabFileDescriptor();
    void getFileName(char *, int *);
public:

    enum HandlerResponse {
        respOk, respForbiddenSyscall, respBlockedFile
    };

    SyscallsHandler(int pid,
            const std::set<std::string> & readAllowedFiles,
            const std::set<std::string> & writeAllowedFiles,
            bool blockSyscalls,
            bool blockFiles) {
        this->pid = pid;
        state = stStart;
        this->readAllowedFiles = readAllowedFiles;
        this->writeAllowedFiles = writeAllowedFiles;
        this->blockSyscalls = blockSyscalls;
        this->blockFiles = blockFiles;
        this->needFileDescriptor = false;
        getRegistersOffsets();
        syscallsMap = getSyscallsMap();
        readAllowedFileDescriptors.insert(0); //stdin
        writeAllowedFileDescriptors.insert(1); //stdout
        writeAllowedFileDescriptors.insert(2); //stderr

    }

    HandlerResponse handleSecurity();

    std::string getErrorString() const {
        return errorString;
    }

    void grabRegs() {
        regs.orig_r1 = ptrace(PTRACE_PEEKUSER, pid, ORIGEAXRegister, NULL);
        regs.r1 = ptrace(PTRACE_PEEKUSER, pid, EAXRegister, NULL);
        regs.r2 = ptrace(PTRACE_PEEKUSER, pid, EBXRegister, NULL);
        regs.r3 = ptrace(PTRACE_PEEKUSER, pid, ECXRegister, NULL);
        regs.r4 = ptrace(PTRACE_PEEKUSER, pid, EDXRegister, NULL);
        //printf("[orig: %ld, r1: %ld, r2: %ld, r3: %ld, r4: %ld]\n", regs.orig_r1, regs.r1, regs.r2, regs.r3, regs.r4);        
    }

    const registers& getRegs() const {
        return regs;
    }

    bool getNeedFileDescriptor() const {
        return needFileDescriptor;
    }
    
    const char * getSyscallName(int no) const {
        std::map<int,std::string>::const_iterator it = syscallsMap.find(no);
        if(it == syscallsMap.end()) {
            return "[unknown syscall]";
        }
        return it->second.c_str();
    }

private:

    void getRegistersOffsets() {
        struct user usr;
#ifdef __x86_64__
        ORIGEAXRegister = (long) ((long) &usr.regs.orig_rax - (long) &usr);
        EAXRegister = (long) ((long) &usr.regs.rax - (long) &usr);
        EBXRegister = (long) ((long) &usr.regs.rdi - (long) &usr);
        ECXRegister = (long) ((long) &usr.regs.rsi - (long) &usr);
        EDXRegister = (long) ((long) &usr.regs.rdx - (long) &usr);
#else
        ORIGEAXRegister = (long) ((long) &usr.regs.orig_eax - (long) &usr);
        EAXRegister = (long) ((long) &usr.regs.eax - (long) &usr);
        EBXRegister = (long) ((long) &usr.regs.ebx - (long) &usr);
        ECXRegister = (long) ((long) &usr.regs.ecx - (long) &usr);
        EDXRegister = (long) ((long) &usr.regs.edx - (long) &usr);
#endif
    }

    template <class T>
    bool contains(std::set<T> set, T element) {
        return set.find(element) != set.end();
    }

    std::string resolveFileMode(int fileMode) {
        switch (fileMode) {
            case 0:
                return std::string("read-only");
            case 1:
                return std::string("write-only");
            default:
                return std::string("read-write");
        }
    }
    
};

#endif	/* SYSCALLSHANDLER_H */


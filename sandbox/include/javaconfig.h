/* 
 * File:   javaconfig.h
 * Author: krzemin
 *
 * Created on 8 styczeń 2011, 17:50
 */

#ifndef JAVACONFIG_H
#define	JAVACONFIG_H

#include "abstractconfig.h"
#include <string>
#include <cstring>
#include <unistd.h>

class JavaConfig : public AbstractConfig {
    std::string classPath;
    std::string className;
    bool jarMode;
    std::string policyPath;
    std::string getJavaPolicyFileContent();
    char xmx[20], xms[20];

public:

    JavaConfig(const AbstractConfig & c) {
        timeLimit = c.getTimeLimit();
        timeUsage = c.getTimeUsage();
        memoryLimit = c.getMemoryLimit();
        memoryUsage = c.getMemUsage();
        inputFile = c.getInputFile();
        outputFile = c.getOutputFile();
        errorFile = c.getErrorFile();
        blockFiles = c.getBlockFiles();
        blockSyscalls = c.getBlockSyscalls();
        enableStats = c.getEnableStats();
        verboseMode = c.getVerboseMode();
        disableThreads = c.getDisableThreads();
        mode = c.getMode();
        writeAllowedFiles = c.getWriteAllowedFiles();
        readAllowedFiles = c.getReadAllowedFiles();
        commandVector = c.getCommandVector();
        errorString = c.getErrorString();
        policyPath = std::string("/tmp/limiter.java.policy");
        javaPath = c.getJavaPath();
    }

    ~JavaConfig() {
        unlink(policyPath.c_str());
    }
    
    void printConfig();
    bool prepare();
    bool setLimits();
    void exec();
    int handle(int childpid);
    bool retrieveUsage();

    std::string getCommand() {
        std::string command = className;
        for (std::vector<std::string>::iterator it = ++commandVector.begin(); it != commandVector.end(); ++it) {
            command += ' ' + std::string(it->c_str());
        }
        return command;
    }
};


#endif	/* JAVACONFIG_H */


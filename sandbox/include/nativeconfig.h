/* 
 * File:   nativeconfig.h
 * Author: krzemin
 *
 * Created on 8 styczeń 2011, 17:24
 */

#ifndef NATIVECONFIG_H
#define	NATIVECONFIG_H

#include "abstractconfig.h"
#include <stdio.h>
class NativeConfig : public AbstractConfig {
public:

    NativeConfig(const AbstractConfig & c) {
        timeLimit = c.getTimeLimit();
        timeUsage = c.getTimeUsage();
        memoryLimit = c.getMemoryLimit();
        memoryUsage = c.getMemUsage();
        extraMemory = c.getExtraMemory();
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
    }
    bool setLimits();
    void exec();
    int handle(int childPid);
};

#endif	/* NATIVECONFIG_H */


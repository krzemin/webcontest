/* 
 * File:   .h
 * Author: krzemin
 *
 * Created on 8 styczeń 2011, 16:37
 */

#ifndef ABSTRACTCONFIG_H
#define	ABSTRACTCONFIG_H

#include<cstdlib>
#include<string>
#include<sys/resource.h>
#include <string>
#include <vector>
#include <set>
#include <getopt.h>
#include <numeric>

class AbstractConfig {

    struct __plus {

        std::string operator()(std::string x, std::string y) {
            return x + y + " ";
        }
    };

protected:
    std::string inputFile;
    std::string outputFile;
    std::string errorFile;
    std::string mode;
    float timeLimit; // sekundy
    float extraTime; // sekundy
    float timeUsage; // sekundy
    long memoryLimit; // kb
    long extraMemory; // kb
    long memoryUsage; // kb
    std::string errorString;
    bool blockFiles;
    bool blockSyscalls;
    bool enableStats;
    bool disableThreads;
    bool verboseMode;
    std::set<std::string> writeAllowedFiles;
    std::set<std::string> readAllowedFiles;
    std::vector<std::string> commandVector;
    std::string javaPath;
    
public:

    AbstractConfig() {
        timeLimit = 0;
        timeUsage = 0;
        memoryLimit = 0;
        memoryUsage = 0;
        inputFile = "";
        outputFile = "";
        errorFile = "";
        blockFiles = false;
        blockSyscalls = false;
        enableStats = false;
        verboseMode = false;
        disableThreads = false;
        mode = "native";
        errorString = "";
        extraTime = 1; // 1s
        extraMemory = 1024 * 32; // 32mb
        errorString = "";
        writeAllowedFiles.clear();
        readAllowedFiles.clear();
        commandVector.clear();
        javaPath = "";
    }

    virtual ~AbstractConfig() {
    };


    bool parseArgv(int argc, char ** argv);
    bool rebindStdIn();
    bool rebindStdOut();
    bool rebindStdErr();
    virtual void printConfig();

    virtual bool prepare() {
    };

    virtual bool setLimits() {
    };
    virtual bool retrieveUsage();

    float getTimeUsage() const {
        return timeUsage;
    }

    long getMemUsage() const {
        return memoryUsage;
    }

    virtual void exec() {
    };

    virtual int handle(int childpid) {
    };

    virtual bool isValid() {
        if (!errorString.compare("") == 0) return false;
        return true;
    }

    std::string getInputFile() const {
        return inputFile;
    }

    std::string getOutputFile() const {
        return outputFile;
    }

    std::string getErrorFile() const {
        return errorFile;
    }

    float getTimeLimit() const {
        return timeLimit;
    }

    long getMemoryLimit() const {
        return memoryLimit;
    }

    long getExtraMemory() const {
        return extraMemory;
    }

    std::string getMode() const {
        return mode;
    }

    bool getBlockFiles() const {
        return blockFiles;
    }

    bool getBlockSyscalls() const {
        return blockSyscalls;
    }

    bool getEnableStats() const {
        return enableStats;
    }

    bool getVerboseMode() const {
        return verboseMode;
    }

    bool getDisableThreads() const {
        return disableThreads;
    }

    std::set<std::string> getWriteAllowedFiles() const {
        return writeAllowedFiles;
    }

    std::set<std::string> getReadAllowedFiles() const {
        return readAllowedFiles;
    }

    std::string getJavaPath() const {
        return javaPath;
    }
    
    std::vector<std::string> getCommandVector() const {
        return commandVector;
    }

    const char * getErrorString() const {
        return errorString.c_str();
    }

    virtual std::string getCommand() const {
        return accumulate(commandVector.begin(), commandVector.end(), std::string(""), __plus());
    }

};


#endif	/* ABSTRACTCONFIG_H */


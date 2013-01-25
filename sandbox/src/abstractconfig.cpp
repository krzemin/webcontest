#include "abstractconfig.h"
#include <iostream>
#include <cstdlib>
#include <cmath>
#include <cstring>
#include <unistd.h>
#include <fcntl.h>
#include <libgen.h>
#include <sys/stat.h>
#include <sys/resource.h>

#include<cstdio>

bool AbstractConfig::parseArgv(int argc, char ** argv) {
    char * rest;
    opterr = 0;
    bool needHelp = false;
    while (true) {
        static struct option longOptions[] = {
            {"block-files", no_argument, NULL, 'f'},
            {"block-syscalls", no_argument, NULL, 'b'},
            {"stats", no_argument, NULL, 's'},
            {"help", no_argument, NULL, 'h'},
            {"verbose", no_argument, NULL, 'v'},
            {"disable-threads", no_argument, NULL, 'd'},
            {"time-limit", required_argument, NULL, 't'},
            {"memory-limit", required_argument, NULL, 'm'},
            {"extra-memory", required_argument, NULL, 'M'},
            {"input-file", required_argument, NULL, 'i'},
            {"output-file", required_argument, NULL, 'o'},
            {"error-file", required_argument, NULL, 'e'},
            {"mode", required_argument, NULL, 'z'},
            {"allow-file", required_argument, NULL, 'a'},
            {"allow-write-only", required_argument, NULL, 'w'},
            {"allow-read-only", required_argument, NULL, 'r'},
            {"java-path", required_argument, NULL, 'j'},
            {0, 0, 0, 0}
        };
        std::string fileName;
        int optionPointer = 0;

        int option = getopt_long(argc, argv, "+fbsvdht:m:M:i:o:e:l:a:w:r:j:", longOptions, &optionPointer);

        if (option == EOF) {
            break;
        }

        switch (option) {
            case 't':
                timeLimit = strtod(optarg, &rest);
                if (*rest != '\0' || timeLimit <= 0) {
                    errorString = "time limit incorrect!";
                    return false;
                }
                break;
            case 'm':
                memoryLimit = strtol(optarg, &rest, 10);
                if (*rest != '\0' || memoryLimit <= 0) {
                    errorString = "memory limit incorrect!";
                    return false;
                }
                memoryLimit *= 1024;
                break;
            case 'M':
                extraMemory = strtol(optarg, &rest, 10);
                if (*rest != '\0' || memoryLimit <= 0) {
                    errorString = "extra memory limit incorrect!";
                    return false;
                }
                extraMemory *= 1024;
                break;
            case 'h':
                needHelp = true;
                break;
            case 'i':
                inputFile = optarg;
                // writeAllowedFiles.insert(inputFile);//push_back(fileName);
                readAllowedFiles.insert(inputFile);//push_back(fileName);
                break;
            case 'o':
                outputFile = optarg;
                writeAllowedFiles.insert(outputFile);//push_back(fileName);
                //readAllowedFiles.insert(outputFile);//push_back(fileName);
                break;
            case 'e':
                errorFile = optarg;
                writeAllowedFiles.insert(errorFile);//push_back(fileName);
                //readAllowedFiles.insert(errorFile);//push_back(fileName);
                break;
            case 'z':
                mode = optarg;
                break;
            case 'f':
                blockFiles = true;
                break;
            case 'd':
                disableThreads = true;
                break;
            case 'b':
                blockSyscalls = true;
                break;
            case 's':
                enableStats = true;
                break;
            case 'v':
                verboseMode = true;
                break;
            case 'a':
                fileName = optarg;
                writeAllowedFiles.insert(fileName);
                readAllowedFiles.insert(fileName);
                break;
            case 'w':
                fileName = optarg;
                writeAllowedFiles.insert(fileName);
                break;
            case 'r':
                fileName = optarg;
                readAllowedFiles.insert(fileName);
            case 'j':
                javaPath = optarg;
                break;
            case '?':
                errorString = "error while parsing arguments";
                return false;
            default:
                errorString = "error while parsing arguments";
                return false;
        }
    }
    if (needHelp) {
        errorString = "help requested";
        return false;
    }
    if (optind == argc) {
        errorString = "missing command";
        return false;
    }
    while (optind < argc) {
        commandVector.push_back(argv[optind++]);
    }
    return isValid();
}

void AbstractConfig::printConfig() {
    printf("\nAbstract limiter configuration:\n");
    printf("Time limit: %f\n", timeLimit);
    printf("Memory limit: %ld\n", memoryLimit);
    printf("Extra memory limit: %ld\n", extraMemory);
    printf("Input file: %s\n", inputFile.c_str());
    printf("Output file: %s\n", outputFile.c_str());
    printf("Mode: %s\n", mode.c_str());
    printf("Block files: %d\n", blockFiles);
    printf("Block syscalls: %d\n", blockSyscalls);
    printf("Enable stats: %d\n", enableStats);
    printf("Show config: %d\n", verboseMode);
    printf("Read allowed files list: ");
    for (std::set<std::string>::iterator it = readAllowedFiles.begin(); it != readAllowedFiles.end(); ++it) {
        printf("%s ", it->c_str());
    }
    printf("\n");
    printf("Write allowed files list: ");
    for (std::set<std::string>::iterator it = writeAllowedFiles.begin(); it != writeAllowedFiles.end(); ++it) {
        printf("%s ", it->c_str());
    }
    printf("\n");
    printf("Command: %s\n\n", getCommand().c_str());
}

bool AbstractConfig::rebindStdIn() {
    if (inputFile.empty()) return true;
    int fdIn;
    if ((fdIn = open(inputFile.c_str(), O_RDONLY)) == -1) {
        errorString = "open(inputFile) failed!";
        return false;
    }
    if (dup2(fdIn, STDIN_FILENO) == -1) {
        errorString = "dup2(fdIn) failed!";
        return false;
    }
    close(fdIn);
    return true;
}

bool AbstractConfig::rebindStdOut() {
    if (outputFile.empty()) return true;
    int fdOut;
    if ((fdOut = open(outputFile.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0600)) == -1) {
        errorString = "open(outputFile) failed!";
        return false;
    }
    if (dup2(fdOut, STDOUT_FILENO) == -1) {
        errorString = "dup2(fdOut) failed!";
        return false;
    }
    close(fdOut);
    return true;
}

bool AbstractConfig::rebindStdErr() {
    if (errorFile.empty()) return true;
    int fdErr;
    if ((fdErr = open(errorFile.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0600)) == -1) {
        errorString = "open(outputFile) failed!";
        return false;
    }
    if (dup2(fdErr, STDERR_FILENO) == -1) {
        errorString = "dup2(fdOut) failed!";
        return false;
    }
    close(fdErr);
    return true;
}

bool AbstractConfig::retrieveUsage() {
    struct rusage stats;
    
    if (getrusage(RUSAGE_CHILDREN, &stats) != 0) {
        errorString = "getrusage() failed!";
        return false;
    }
    
    double utime = (double) stats.ru_utime.tv_sec + (double) stats.ru_utime.tv_usec / 1000000.0;
    double stime = (double) stats.ru_stime.tv_sec + (double) stats.ru_stime.tv_usec / 1000000.0;
    timeUsage = std::max(timeUsage, (float)(utime + stime));
    memoryUsage = std::max(memoryUsage, stats.ru_maxrss);
    
    //printf("time: %f   mem: %ld\n", timeUsage, memoryUsage);
    
    return true;
}
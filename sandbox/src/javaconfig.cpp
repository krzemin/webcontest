#include "javaconfig.h"
#include <fstream>
#include <string>
#include <cstring>
#include <cmath>
#include <sys/wait.h>
#include <libgen.h>
#include <cstdio>

bool JavaConfig::prepare() {
    std::string javaFile = commandVector.at(0); //getCommand();
    if (javaFile == "") {
        errorString = "missing java file";
        return false;
    }
    int extensionIndex = javaFile.find_last_of(".");
    std::string extension = "";
    if (extensionIndex >= 0) {
        extension = javaFile.substr(extensionIndex, javaFile.size() - 1);
    }

    if (extension.compare(".jar") == 0) {
        jarMode = true;
        classPath = "";
        className = javaFile;
    } else if (extension.compare(".class") == 0) {
        jarMode = false;
        classPath = dirname(strdupa(javaFile.c_str()));
        className = basename(strdupa(javaFile.substr(0, extensionIndex).c_str()));
    } else {
        errorString = "invalid file extension (expected .jar or .class)";
        return false;
    }

    //policyPath = std::string("/tmp/limiter.java.policy");
    std::ofstream pf;
    pf.open(policyPath.c_str(), std::ios_base::out | std::ios_base::trunc);
    if (!pf.good()) {
        errorString = "cannot create Java Security Policy file";
        return false;
    }
    pf << getJavaPolicyFileContent();
    pf.close();

    return true;
}

void JavaConfig::printConfig() {
    AbstractConfig::printConfig();
    printf("Java limiter configuration:\n");
    printf("Jar mode: %d\n", jarMode);
    printf("Class path: %s\n", classPath.c_str());
    printf("Class name: %s\n", className.c_str());
    printf("Java command: %s\n\n", getCommand().c_str());
}

std::string JavaConfig::getJavaPolicyFileContent() {
    std::string p;
    p += "grant codeBase \"file:${{java.ext.dirs}}/*\" {\n";
    p += "permission java.security.AllPermission;\n";
    p += "};\n";
    
    p += "grant {\n";
    if (blockFiles) {
        
        for (std::set<std::string>::iterator it = readAllowedFiles.begin();
                it != readAllowedFiles.end(); ++it) {
            p += "permission java.io.FilePermission \"";
            p += *it;
            p += "\", \"read\";\n";
        }
        for (std::set<std::string>::iterator it = writeAllowedFiles.begin();
                it != writeAllowedFiles.end(); ++it) {
            p += "permission java.io.FilePermission \"";
            p += *it;
            p += "\", \"write\";\n";
        }
    } else {
        p += "permission java.io.FilePermission \"*\", \"write\";\n";
    }
    p += "};\n";
    
    return p;
}

bool JavaConfig::setLimits() {
    struct rlimit rls;
    rls.rlim_cur = rls.rlim_max = ceil(timeLimit + extraTime);
    if (setrlimit(RLIMIT_CPU, &rls) != 0) {
        errorString = "setrlimit(RLIMIT_CPU) failed!";
        return false;
    }
    if (memoryLimit > 0) {
        sprintf(xmx, "-Xmx%dm", (int) ceil((float) memoryLimit / 1024.0f));
        sprintf(xms, "-Xms%dm", (int) ceil((float) memoryLimit / 1024.0f));
    }
    return true;
}

void JavaConfig::exec() {

    std::vector<std::string> argumentsVector;
    if (javaPath.empty()) {
        argumentsVector.push_back("java");
    } else {
        argumentsVector.push_back(javaPath + "/bin/java");
    }
    if (jarMode) {
        argumentsVector.push_back("-jar");
    } else {
        argumentsVector.push_back("-cp");
        argumentsVector.push_back(classPath);
    }
    if (memoryLimit > 0) {
        argumentsVector.push_back(xmx);
        argumentsVector.push_back(xms);
    }
    argumentsVector.push_back("-Djava.security.manager");
    argumentsVector.push_back(std::string("-Djava.security.policy=") + policyPath);
    argumentsVector.push_back(className);
    for (std::vector<std::string>::iterator it = ++commandVector.begin(); it != commandVector.end(); ++it) {
        argumentsVector.push_back(it->c_str());
        printf("%s\n", it->c_str());
    }

    int argc = argumentsVector.size() + 1;
    const char * arguments[argc];
    for (std::vector<std::string>::iterator it = argumentsVector.begin(); it != argumentsVector.end(); ++it) {
        arguments[it - argumentsVector.begin()] = it->c_str();
    }
    arguments[argc - 1] = NULL;
    //    if (jarMode) {
    //        execlp("java", "java", "-jar", xmx, xms, "-Djava.security.manager",
    //                (std::string("-Djava.security.policy=") + policyPath).c_str(),
    //                className.c_str(), (char*) NULL);
    //    } else {
    //        execlp("java", "java", xmx, xms, "-Djava.security.manager",
    //                (std::string("-Djava.security.policy=") + policyPath).c_str(),
    //                "-cp", classPath.c_str(), className.c_str(), (char*) NULL);
    //    }
    execvp((const char*) arguments[0], (char * const *) arguments);
}

int JavaConfig::handle(int childpid) {
    int status;
    waitpid(childpid, &status, 0);
    return status;
}

bool JavaConfig::retrieveUsage() {
    if (!AbstractConfig::retrieveUsage()) {
        return false;
    }
    memoryUsage = std::min(memoryUsage, memoryLimit);
    return true;
}


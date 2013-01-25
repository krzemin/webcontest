/* 
 * File:   main.cpp
 * Author: krzemins
 *
 * Created on 20 lipiec 2011, 13:38
 */

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <unistd.h>
#include <sys/wait.h>

#include "output.h"

#include "abstractconfig.h"
#include "nativeconfig.h"
#include "javaconfig.h"

int main(int argc, char * argv[]) {

    pid_t childPid;

    AbstractConfig * initCfg = new AbstractConfig();
    AbstractConfig * cfg;

    if (!initCfg->parseArgv(argc, argv)) {
        printUsage();
        return 0;
    }

    if (initCfg->getMode() == "java") {
        cfg = new JavaConfig(*initCfg);
    } else {
        cfg = new NativeConfig(*initCfg);
    }
    delete initCfg;
    cfg->prepare();

    if (!cfg->isValid()) {
        print(IE, cfg->getErrorString());
        return 2;
    }
    if (cfg->getVerboseMode()) {
        cfg->printConfig();
    }
    
    //close(2);

    switch ((childPid = fork())) {

        case -1:
            print(IE, "fork failed");
            break;

        case 0:

            if (!cfg->rebindStdIn()) {
                print(IE, cfg->getErrorString());
                return 3;
            }

            if (!cfg->rebindStdOut()) {
                print(IE, cfg->getErrorString());
                return 4;
            }

            if (!cfg->rebindStdErr()) {
                print(IE, cfg->getErrorString());
                return 4;
            }

            if (!cfg->setLimits()) {
                print(IE, cfg->getErrorString());
                return 5;
            }
            cfg->exec();

            return 6;
            break;

        default:
            int exitStatus = cfg->handle(childPid);
            if (cfg->getEnableStats()) {
                if (cfg->retrieveUsage()) {
                    if (cfg->getTimeLimit() > 0
                            && cfg->getTimeUsage() > cfg->getTimeLimit()) {
                        print(TLE, cfg->getTimeUsage(), cfg->getMemUsage());
                    } else if (cfg->getMemoryLimit() > 0
                            && cfg->getMemUsage() > cfg->getMemoryLimit()) {
                        print(MLE, cfg->getTimeUsage(), cfg->getMemUsage());
                    } else if (WIFEXITED(exitStatus) && WEXITSTATUS(exitStatus) == 0) {
                        print(OK, cfg->getTimeUsage(), cfg->getMemUsage());
                    } else {
                        print(RE, cfg->getTimeUsage(), cfg->getMemUsage());
                    }
                } else {
                    print(IE, cfg->getErrorString());
                }
            }
            if (cfg->getVerboseMode()) {
                printf("Last error: %s\n", cfg->getErrorString());
            }
    }

    delete cfg;

    return 0;
}

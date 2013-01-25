#include "output.h"
#include <cstdio>

const char * outputCodeStr(OutputResult code) {
    switch (code) {
        case OK: return "OK";
        case TLE: return "TLE";
        case MLE: return "MLE";
        case RE: return "RE";
        case IE: return "IE";
    }
}

void print(OutputResult code, float maxTime, long maxMemory) {
    switch (code) {
        case TLE:
            printf("TLE %ld\n", maxMemory);
            break;
        case MLE:
            printf("MLE %.2f\n", maxTime);
            break;
        case OK:
            printf("OK %.2f %ld\n", maxTime, maxMemory);
            break;
        case RE:
            printf("RE %.2f %ld\n", maxTime, maxMemory);
            break;
        default:
            printf("\n");
    }
}

void print(OutputResult code, const char * message) {
    printf("%s %s\n", outputCodeStr(code), message);
}

void printUsage() {
    const char * usage =
    "\n"
    "Usage:\n"
    "   limiter [options] command [arguments]\n"
    "Limiter options:\n"
    "   -t x, --time-limit x\n"
    "       set time limit x for command to x seconds,\n"
    "       default: no limit\n"
    "   -m x, --memory-limit x\n"
    "       set memory limit for command to x megabytes,\n"
    "       default: no limit\n"
    "   -M x, --extra-memory x\n"
    "       set extra memory limit for command to x megabytes,\n"
    "       default: 32 mb\n"
    "   -s, --stats\n"
    "       print execution code and resource usage statistics\n"
    "   -h, --help\n"
    "       print limiter help\n"
    "   -v, --verbose\n"
    "       print limiter configuration and messages\n"
    "   -b, --block-syscalls\n"
    "       enable blocking forbidden syscalls for execution\n"
    "       of command (not used in java mode)\n"
    "   -d, --disable-threads\n"
    "       disable threads for execution of command\n"
    "       (not implemented yet in java mode)\n"
    "   -f, --block-files\n"
    "       disable access to files by command\n"
    "   -i x, --input-file x\n"
    "       set input file for command as x,\n"
    "       default: stdin\n"
    "   -o x, --output-file x\n"
    "       set output file for command as x,\n"
    "       default: stdout\n"
    "   -e x, --error-file x\n"
    "       set error file for command as x,\n"
    "       default: stderr\n"
    "   -z x, --mode x\n"
    "       set binary execution mode to x; currently there are two\n"
    "       supported modes: native and java; default: native\n"
    "   -j x, --java-path x\n"
    "       set Java Development Kit path to x; if not set, system\n"
    "       default JDK is used\n"
    "   -a x, --allow-file x\n"
    "       allow command to write and read to file x\n"
    "   -w x, --allow-write-only x\n"
    "       allow command to write to file x\n"
    "   -r x, --allow-read-only x\n"
    "       allow command to read to file x\n"
    ;
    printf("%s", usage);
}
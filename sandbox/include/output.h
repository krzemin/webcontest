/* 
 * File:   output.h
 * Author: krzemin
 *
 * Created on 7 styczeń 2011, 18:51
 */

#ifndef OUTPUT_H
#define	OUTPUT_H

typedef enum {
    OK, RE, TLE, MLE, IE
} OutputResult;

void print(OutputResult code, float maxTime, long maxMemory);
void print(OutputResult code, const char * message);
void printUsage();

#endif	/* OUTPUT_H */


#ifndef __OPTIONS_H__
#define __OPTIONS_H__

#include <vector>
#include <string>

struct options {
	std::vector<std::string> 	command;
	std::string					input_file;
	std::string 				output_file;
	std::string 				error_file;
	bool						verbose;
	float						time_limit;
	long						memory_limit;
	bool						secure;

	options();
	bool parse(int argc, const char * const argv[]);
};

#endif // __OPTIONS_H__
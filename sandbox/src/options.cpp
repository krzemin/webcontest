#include "options.hpp"
#include <cstdlib>
#include <cstring>
#include <unistd.h>
#include <getopt.h>

const struct option long_options[] = {
	{"help", no_argument, NULL, 'h'},
	{"verbose", no_argument, NULL, 'v'},
	{"secure", no_argument, NULL, 's'},
	{"time-limit", required_argument, NULL, 't'},
	{"memory-limit", required_argument, NULL, 'm'},
	{"input-file", required_argument, NULL, 'i'},
	{"output-file", required_argument, NULL, 'o'},
	{"error-file", required_argument, NULL, 'e'},
	{0, 0, 0, 0}
};

const char getopt_str[] = "+hvst:m:i:o:e:";

options::options()
	: verbose(false),
	  time_limit(0.0),
	  memory_limit(0),
	  secure(false)
{
}

#include <iostream>
bool options::parse(int argc, const char * const argv[]) {
	opterr = 0;
	optind = 0;

	char * argv_copy[argc];
	for(int i = 0; i < argc; ++i) {
		size_t n = strlen(argv[i]) + 1;
		argv_copy[i] = (char*) malloc(n);
		memcpy(argv_copy[i], argv[i], n);
	}

	while(true) {
		char *rest;
		int option_pointer = 0;
		int option = getopt_long(argc, argv_copy, getopt_str,
								 long_options, &option_pointer);

		//std::cout << "option = " << option << std::endl;
		if(option == EOF) {
			break;
		}

		switch(option) {
			case 'h':
				return false;
			break;
			case 'v':
				verbose = true;
			break;
			case 's':
				secure = true;
			break;
			case 't':
				time_limit = strtod(optarg, &rest);
				if(*rest != '\0' || time_limit <= 0.0) {
					return false;
				}
			break;
			case 'm':
				memory_limit = strtol(optarg, &rest, 10);
				if(*rest != '\0' || memory_limit <= 0) {
					return false;
				}
			break;
			case 'i':
				input_file = optarg;
				//std::cout << "input_file = " << input_file << std::endl;
			break;
			case 'o':
				output_file = optarg;
			break;
			case 'e':
				error_file = optarg;
			break;
			case '?':
				return false;
			break;
			default:
				return false;
		}
	}

	if(optind == argc) {
		return false;
	}

	while(optind < argc) {
		command.push_back(argv[optind++]);
	}

	return true;
}
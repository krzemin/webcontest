#include <iostream>
#include <memory>
#include "options.hpp"

int main(int argc, char ** argv) {

	auto options = make_shared<options>();

	if(!options->parse(argc, argv)) {
		std::cerr << printer::help();
		return 1;
	}

	if(options->verbose) {
		std::cerr << printer::options(options);
	}

	auto executable = make_shared<executable>();

	if(!executable->prepare(options)) {
		std::cerr << printer::error("error preparing executable to run");
		return 2;
	}

	pid_t child_pid;

	switch((child_pid = fork())) {
		case -1:
			std::cerr << printer::error("fork() failed");
			return 3;
		break;
		case 0:
			executable->child_part();
		break;
		default:
			executable->parent_part();
	}

	if(options->verbose) {
		std::cerr << printer::stats(executable->get_stats());
	}

	std::cerr << printer::result(executable->get_result());

	return 0;
}
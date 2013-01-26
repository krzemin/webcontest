#include <iostream>
#include <memory>
#include "options.hpp"

int main(int argc, char ** argv) {

	auto options = make_shared<options>();

	if(!options->parse(argc, argv)) {
		printer::print_help();
		return 1;
	}

	if(options->verbose) {
		printer::print_options(options);
	}

	auto executable = make_shared<executable>();

	if(!executable->prepare(options)) {
		printer::print_error("")
		return 2;
	}

	pid_t child_pid;

	switch((child_pid = fork())) {
		case -1:
			Printer::print_internal_error("fork() failed");
			return 3;
		break;
		case 0:
			executable->child_part();
		break;
		default:
			executable->parent_part();
	}

	if(options->verbose) {
		printer::print_stats(executable->get_stats());
	}

	printer::print_result(executable->get_result());

	return 0;
}
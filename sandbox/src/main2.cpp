#include <iostream>
#include <memory>
#include "options.hpp"
#include "security.hpp"

int main(int argc, char ** argv) {

	auto options = make_shared<options>();

	if(!options->parse(argc, argv)) {
		std::cerr << printer::help();
		return 1;
	}

	std::shared_ptr<security_manager> security;

	if(options->verbose) {
		std::cerr << printer::options(options);
		security = make_shared<linux_syscalls_security_manager>(options);
	} else {
		security = make_shared<dummy_security_manager>(options)
	}

	auto executable = make_shared<executable>(options, security);

	if(!executable->prepare()) {
		std::cerr << printer::error("error preparing executable to run;");
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
			executable->parent_part(child_pid);
	}

	if(options->verbose) {
		std::cerr << printer::stats(executable->get_stats());
	}

	std::cerr << printer::result(executable->get_result());

	return 0;
}
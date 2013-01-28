#ifndef __EXECUTABLE_HPP__
#define __EXECUTABLE_HPP__

#include <memory>
#include "options.hpp"
#include "security_manager.hpp"
#include "stats.hpp"
#include "results.hpp"

class executable {
public:
	executable(std::shared_ptr<options> opts, std::shared_ptr<security_manager> sm)
		: options(opts), security(sm) {}

	~executable();

	bool prepare();
	void child_part();
	void parent_part(pid_t);
	stats get_stats();
	results get_results();

private:
	std::shared_ptr<options> options;
	std::shared_ptr<security_manager> security;
	
};

#endif // __EXECUTABLE_HPP__
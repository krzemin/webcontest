#ifndef __SECURITY_MANAGER_HPP__
#define __SECURITY_MANAGER_HPP__

#include <memory>
#include "options.hpp"

class security_manager {
public:
	security_manager(std::shared_ptr<options>)
        : opts(opts) {};
	virtual ~security_manager() {};

	virtual int run_until_trap() = 0;
	virtual bool is_trap_safe(int trap) = 0;

protected:
    std::shared_ptr<options> opts;

};

#endif // __SECURITY_MANAGER_HPP__
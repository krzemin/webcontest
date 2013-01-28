#ifndef __SECURITY_MANAGER_HPP__
#define __SECURITY_MANAGER_HPP__

#include <memory>

class security_manager {
public:
	security_manager(std::shared_ptr<options> &);
	virtual ~security_manager();

	virtual int run_until_trap();
	virtual bool is_trap_safe(int trap);

};

#endif // __SECURITY_MANAGER_HPP__
#ifndef __SECURITY_MANAGER_MOCK_HPP__
#define __SECURITY_MANAGER_MOCK_HPP__

#include <memory>

class security_manager_mock : public security_manager {
public:
	security_manager_mock();

	MOCK_METHOD0(run_until_trap, int());
	MOCK_METHOD1(is_trap_safe, bool(int));

};

#endif // __SECURITY_MANAGER_MOCK_HPP__
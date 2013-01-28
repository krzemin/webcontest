#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <memory>
#include "executable.hpp"
#include "options.hpp"
#include "security_manager_mock.hpp"

using namespace ::testing;

class executable_test : public ::testing::Test {
protected:
    std::shared_ptr<executable> sut;
    std::shared_ptr<options> options;
    std::shared_ptr<security_manager_mock> security;

    void SetUp() {
        //options = std::make_shared<options>();
        //security = std::make_shared<security_manager_mock>();
        //sut = std::make_shared<executable>(options, security);
    }
    void TearDown() {}
};


TEST_F(executable_test, test_nothing) {
    ASSERT_TRUE(true);
}

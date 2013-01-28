#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <memory>
#include "options.hpp"
#include "executable.hpp"
#include "mocks/security_manager_mock.hpp"

using namespace ::testing;

class executable_test : public ::testing::Test {
protected:
    std::shared_ptr<options> opts;
    std::shared_ptr<security_manager_mock> security;
    std::shared_ptr<executable> sut;

    void SetUp() {
        opts = std::make_shared<options>();
        security = std::make_shared<security_manager_mock>(opts);
        sut = std::make_shared<executable>(opts, security);
    }
    void TearDown() {}
};


TEST_F(executable_test, test_nothing) {
    ASSERT_TRUE(true);
}

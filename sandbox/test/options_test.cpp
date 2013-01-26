#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <array>
#include "options.hpp"

using namespace ::testing;

class options_test : public ::testing::Test {
protected:
    options *sut;
    void SetUp() {
        sut = new options();
    }
    void TearDown() {
        delete sut;
    }
};


TEST_F(options_test, test_empty_args) {
    ASSERT_EQ(std::vector<std::string>(), sut->command);
    ASSERT_EQ("", sut->input_file);
    ASSERT_EQ("", sut->output_file);
    ASSERT_EQ("", sut->error_file);
    ASSERT_FALSE(sut->verbose);
    ASSERT_EQ(0.0, sut->time_limit);
    ASSERT_EQ(0, sut->memory_limit);
    ASSERT_FALSE(sut->secure);
}

TEST_F(options_test, test_command) {
    const char * const args[2] = { "argv[0]", "command" };
    std::vector<std::string> cmd = { "command" };
    ASSERT_TRUE(sut->parse(2, args));
    ASSERT_EQ(cmd, sut->command);
}

TEST_F(options_test, test_command_more_options) {
    const char * const args[4] = { "argv[0]", "./command", "-i", "--option" };
    std::vector<std::string> cmd = { "./command", "-i", "--option" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
}

TEST_F(options_test, test_input_file_long) {
    const char * const args[4] = { "argv[0]", "--input-file", "filename", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("filename", sut->input_file);
}

TEST_F(options_test, test_input_file_short) {
    const char * const args[4] = { "argv[0]", "-i", "filename", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("filename", sut->input_file);
}

TEST_F(options_test, test_output_file_long) {
    const char * const args[4] = { "argv[0]", "--output-file", "filename", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("filename", sut->output_file);
}

TEST_F(options_test, test_output_file_short) {
    const char * const args[4] = { "argv[0]", "-o", "filename", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("filename", sut->output_file);
}


TEST_F(options_test, test_error_file_long) {
    const char * const args[4] = { "argv[0]", "--error-file", "filename", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("filename", sut->error_file);
}

TEST_F(options_test, test_error_file_short) {
    const char * const args[4] = { "argv[0]", "-e", "filename", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("filename", sut->error_file);
}

TEST_F(options_test, test_verbose) {
    const char * const args[3] = { "argv[0]", "-v", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(3, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_TRUE(sut->verbose);
}

TEST_F(options_test, test_time_limit_long) {
    const char * const args[4] = { "argv[0]", "--time-limit", "2.5", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ(2.5, sut->time_limit);
}

TEST_F(options_test, test_time_limit_short) {
    const char * const args[4] = { "argv[0]", "-t", "2.5", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ(2.5, sut->time_limit);
}

TEST_F(options_test, test_time_limit_error_zero) {
    const char * const args[4] = { "argv[0]", "--time-limit", "0", "cmd" };
    ASSERT_FALSE(sut->parse(4, args));
}

TEST_F(options_test, test_time_limit_error_ltzero) {
    const char * const args[4] = { "argv[0]", "--time-limit", "-6.21", "cmd" };
    ASSERT_FALSE(sut->parse(4, args));
}

TEST_F(options_test, test_memory_limit_long) {
    const char * const args[4] = { "argv[0]", "--memory-limit", "10249", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ(10249, sut->memory_limit);
}

TEST_F(options_test, test_memory_limit_short) {
    const char * const args[4] = { "argv[0]", "-m", "10249", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(4, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ(10249, sut->memory_limit);
}

TEST_F(options_test, test_memory_limit_error_zero) {
    const char * const args[4] = { "argv[0]", "--memory-limit", "0", "cmd" };
    ASSERT_FALSE(sut->parse(4, args));
}

TEST_F(options_test, test_memory_limit_error_ltzero) {
    const char * const args[4] = { "argv[0]", "--memory-limit", "-621", "cmd" };
    ASSERT_FALSE(sut->parse(4, args));
}

TEST_F(options_test, test_secure) {
    const char * const args[3] = { "argv[0]", "-s", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(3, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_TRUE(sut->secure);
}

TEST_F(options_test, test_complex1) {
    const char * const args[11] = { "argv[0]", "-s", "-t", "4", "-i", "--",
                                   "-e", "--error", "cmd", "--param", "-50" };
    std::vector<std::string> cmd = { "cmd", "--param", "-50" };
    ASSERT_TRUE(sut->parse(11, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("--", sut->input_file);
    ASSERT_EQ("", sut->output_file);
    ASSERT_EQ("--error", sut->error_file);
    ASSERT_FALSE(sut->verbose);
    ASSERT_EQ(4.0, sut->time_limit);
    ASSERT_EQ(0, sut->memory_limit);
    ASSERT_TRUE(sut->secure);
}

TEST_F(options_test, test_complex2) {
    const char * const args[7] = { "argv[0]", "-v", "-m", "400", "-o", "yyy", "cmd" };
    std::vector<std::string> cmd = { "cmd" };
    ASSERT_TRUE(sut->parse(7, args));
    ASSERT_EQ(cmd, sut->command);
    ASSERT_EQ("", sut->input_file);
    ASSERT_EQ("yyy", sut->output_file);
    ASSERT_EQ("", sut->error_file);
    ASSERT_TRUE(sut->verbose);
    ASSERT_EQ(0.0, sut->time_limit);
    ASSERT_EQ(400, sut->memory_limit);
    ASSERT_FALSE(sut->secure);
}

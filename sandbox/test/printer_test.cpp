#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <array>
#include "printer.hpp"

using namespace ::testing;

TEST(printer_test, test_help) {
    ASSERT_EQ("HELP TEXT\n", printer::help());
}

TEST(printer_test, test_error) {
    ASSERT_EQ("ERROR: some message\n", printer::error("some message"));
}

TEST(printer_test, test_opts_default) {
    options opts;
    ASSERT_EQ(
        "Options read from command line:\n"
        "command:\tnone\n"
        "input file:\tnone\n"
        "output file:\tnone\n"
        "error file:\tnone\n"
        "verbose:\tno\n"
        "time limit:\tnone\n"
        "memory limit:\tnone\n"
        "secure:\t\tno\n",
        printer::opts(opts));
}

TEST(printer_test, test_opts_set) {
    options opts;
    
    opts.command = { "command", "--arg", "value" };
    opts.input_file = "../file/path";
    opts.output_file = "file";
    opts.error_file = "file/path";
    opts.verbose = true;
    opts.time_limit = 1.23;
    opts.memory_limit = 12345;
    opts.secure = true;

    ASSERT_EQ(
        "Options read from command line:\n"
        "command:\t\"command --arg value\"\n"
        "input file:\t\"../file/path\"\n"
        "output file:\t\"file\"\n"
        "error file:\t\"file/path\"\n"
        "verbose:\tyes\n"
        "time limit:\t1.23\n"
        "memory limit:\t12345\n"
        "secure:\t\tyes\n",
        printer::opts(opts));
}
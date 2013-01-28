#include <sstream>
#include <numeric>
#include "printer.hpp"
#include "help.hpp"

std::string printer::help() {
    return std::string(HELP_TEXT);
}

std::string printer::error(const std::string & msg) {
    std::ostringstream os;
    os << "ERROR: " << msg << std::endl;
    return os.str();
}

struct __strplus__ {
    std::string operator()(std::string x, std::string y) {
        return x + y + " ";
    }
};

std::string printer::opts(options & opts) {
    std::ostringstream os;
    std::string command = opts.command.empty()
                            ? "none"
                            : std::accumulate(
                                opts.command.begin(),
                                opts.command.end(),
                                std::string(""),
                                __strplus__());
    if(command != "none") {
        command = "\"" + command;
        command.back() = '"';
    }

    std::string input_file = opts.input_file.empty()
                                ? "none"
                                : '"' + opts.input_file + '"';
    std::string output_file = opts.output_file.empty()
                                ? "none"
                                : '"' + opts.output_file + '"';
    std::string error_file = opts.error_file.empty()
                                ? "none"
                                : '"' + opts.error_file + '"';

    std::ostringstream os2;
    os2.precision(2);
    os2.setf(std::ios::fixed, std::ios::floatfield);
    os2 << opts.time_limit;

    std::string time_limit = opts.time_limit > 0.0
                                ? os2.str()
                                : "none";

    std::string memory_limit = opts.memory_limit > 0
                                ? std::to_string(opts.memory_limit)
                                : "none";

    os  << "Options read from command line:" << std::endl
        << "command:\t" << command << std::endl
        << "input file:\t" << input_file << std::endl
        << "output file:\t" << output_file << std::endl
        << "error file:\t" << error_file << std::endl
        << "verbose:\t" << (opts.verbose ? "yes" : "no") << std::endl
        << "time limit:\t" << time_limit << std::endl
        << "memory limit:\t" << memory_limit << std::endl
        << "secure:\t\t" << (opts.secure ? "yes" : "no") << std::endl;

    return os.str();
}
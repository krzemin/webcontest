#ifndef __PRINTER_HPP__
#define __PRINTER_HPP__

#include <string>
#include "options.hpp"

class printer {
public:
    static std::string help();
    static std::string error(const std::string &);
    static std::string opts(options &);
//    static std::string stats(stats &);
//    static std::string result(result &);
};

#endif // __PRINTER_HPP__
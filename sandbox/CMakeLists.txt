PROJECT(sandbox)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
ENABLE_TESTING(true)
FIND_PACKAGE(GTest REQUIRED)
INCLUDE_DIRECTORIES(include)
ADD_DEFINITIONS(-O2 -std=c++11 -Wall)


SET(sandbox_sources
    src/main.cpp
    src/abstractconfig.cpp
    src/javaconfig.cpp
    src/nativeconfig.cpp
    src/output.cpp
    src/syscalls32.cpp
    src/syscalls64.cpp
    src/syscallshandler.cpp
)

#ADD_EXECUTABLE(sandbox ${sandbox_sources})


SET(gtest_gmock_libs gtest gtest_main gmock gmock_main pthread)

SET(options_test_sources
    src/options.cpp
    test/unit/options_test.cpp
)
ADD_EXECUTABLE(options_test ${options_test_sources})
TARGET_LINK_LIBRARIES(options_test ${gtest_gmock_libs})
ADD_TEST(options_test options_test)

SET(printer_test_sources
    src/options.cpp
    src/printer.cpp
    test/unit/printer_test.cpp
)
ADD_EXECUTABLE(printer_test ${printer_test_sources})
TARGET_LINK_LIBRARIES(printer_test ${gtest_gmock_libs})
ADD_TEST(printer_test printer_test)

SET(executable_test_sources
    src/options.cpp
    src/executable.cpp
    test/unit/executable_test.cpp
)
ADD_EXECUTABLE(executable_test ${executable_test_sources})
TARGET_LINK_LIBRARIES(executable_test ${gtest_gmock_libs})
ADD_TEST(executable_test executable_test)


ADD_CUSTOM_TARGET (distclean @echo cleaning for source distribution)
SET(DISTCLEANED
    CMakeFiles
    cmake.depends
    cmake.check_depends
    CMakeCache.txt
    cmake.check_cache
    *.cmake
    Makefile
    core core.*
    gmon.out
    *~
    Testing
)
ADD_CUSTOM_COMMAND(
  DEPENDS clean
  COMMENT "distribution clean"
  COMMAND rm
  ARGS    -Rf CMakeTmp ${DISTCLEANED}
  TARGET  distclean
)

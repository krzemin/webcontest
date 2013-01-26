PROJECT(sandbox)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
ENABLE_TESTING(true)
FIND_PACKAGE(GTest REQUIRED)
INCLUDE_DIRECTORIES(include)
ADD_DEFINITIONS(-g -O2 -std=c++11 -Wall)


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
    test/options_test.cpp
)
ADD_EXECUTABLE(options_test ${options_test_sources})
TARGET_LINK_LIBRARIES(options_test ${gtest_gmock_libs})
ADD_TEST(options_test options_test)


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

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

SET(sandbox_test_sources
    test/example.cpp
)

ADD_EXECUTABLE(sandbox ${sandbox_sources})

ADD_EXECUTABLE(sandbox_tests ${sandbox_test_sources})
TARGET_LINK_LIBRARIES(sandbox_tests gtest gtest_main gmock gmock_main pthread)
ADD_TEST(sandbox_tests sandbox_tests)


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


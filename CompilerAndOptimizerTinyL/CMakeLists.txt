cmake_minimum_required(VERSION 3.6)
project(CompilerAndOptimizerTinyL)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES
    tests/test0
    tests/test1
    tests/test2
    tests/test3
    tests/test4
    tests/test5
    tests/testdummy
    compile.sol
    Compiler.c
    Instr.h
    InstrUtils.c
    InstrUtils.h
    Makefile
    optimize.sol
    Optimizer.c
    sim
    Utils.c
    Utils.h)

add_executable(CompilerAndOptimizerTinyL ${SOURCE_FILES})
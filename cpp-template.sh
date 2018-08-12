#!/usr/bin/bash

if [ $# -eq 0 ]
    then 
        echo "Project name required"
        exit 1
fi

# Get project name from parameter
project_name=$1

# Create main folder with project name and tests/ src/ subdirectories
#mkdir -p $project_name/{src,tests}
echo "--> Creating folder structure..."
mkdir -p $project_name/src
mkdir -p $project_name/tests
mkdir -p $project_name/build

# Add README.md file
echo "--> Adding README.md file..."
touch $project_name/README.md
cat > $project_name/README.md << EOF
# $project_name
EOF

# Add .gitignore file
echo "--> Adding .gitignore file..."
touch $project_name/.gitignore
cat > $project_name/.gitignore << EOF
build/
.vscode/
EOF

echo "--> Creating CMakeLists files..."
# Create main CMakeLists file
touch $project_name/CMakeLists.txt
cat > $project_name/CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.5)

set (CMAKE_C_COMPILER "/usr/bin/x86_64-linux-gnu-gcc-7")
set (CMAKE_CXX_COMPILER "/usr/bin/x86_64-linux-gnu-g++-7")

set (CMAKE_CXX_STANARD 11)

project("$project_name")

add_subdirectory(src)

enable_testing()

add_subdirectory(tests)
EOF

# Create test CMakeLists files with GTest
touch $project_name/tests/CMakeLists.txt
cat > $project_name/tests/CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.5)

find_package(Threads REQUIRED)

project("$project_name Tests")

set(CMAKE_CXX_STANDARD 11)

configure_file(CMakeLists.txt.in googletest-download/CMakeLists.txt)

execute_process(COMMAND \${CMAKE_COMMAND} -G "\${CMAKE_GENERATOR}" .
                RESULT_VARIABLE result
                WORKING_DIRECTORY \${CMAKE_CURRENT_BINARY_DIR}/googletest-download)

if(result)
    message(FATAL_ERROR "CMake step for googletest failed: ${resul}")
endif()

execute_process(COMMAND \${CMAKE_COMMAND} --build .
                RESULT_VARIABLE result
                WORKING_DIRECTORY \${CMAKE_CURRENT_BINARY_DIR}/googletest-download)

if(result)
    message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif()

add_subdirectory(\${CMAKE_CURRENT_BINARY_DIR}/googletest-src 
                \${CMAKE_CURRENT_BINARY_DIR}/googletest-build
                EXCLUDE_FROM_ALL)
    
add_executable(project-test ${project_name}-test.cpp)

target_link_libraries(project-test libproject gtest_main)

add_test(NAME $project_name COMMAND project-test)
EOF

touch $project_name/tests/CMakeLists.txt.in
cat > $project_name/tests/CMakeLists.txt.in << EOF
cmake_minimum_required(VERSION 2.8.2)

project(googletest-download NONE)

include(ExternalProject)

ExternalProject_Add(googletest
                    GIT_REPOSITORY https://github.com/google/googletest.git
                    GIT_TAG master
                    SOURCE_DIR "\${CMAKE_CURRENT_BINARY_DIR}/googletest-src"
                    BINARY_DIR "\${CMAKE_CURRENT_BINARY_DIR}/googletest-build"
                    CONFIGURE_COMMAND ""
                    BUILD_COMMAND ""
                    INSTALL_COMMAND ""
                    TEST_COMMAND "")
EOF

# Create src CMakeFileLists file
touch $project_name/src/CMakeLists.txt
cat > $project_name/src/CMakeLists.txt << EOF
file(GLOB SOURCE_FILES *.cpp *.h)

add_library(libproject STATIC \${SOURCE_FILES})
set_target_properties(libproject PROPERTIES LINKER_LANGUAGE CXX)

target_include_directories(libproject PUBLIC \${CMAKE_CURRENT_SOURCE_DIR})
EOF

# Create a test file
echo "--> Creating test file..."
touch $project_name/tests/${project_name}-test.cpp
cat > $project_name/tests/${project_name}-test.cpp << EOF
#include <iostream>
#include "gtest/gtest.h"

// your project includes

namespace{
    class $project_name : public::testing::Test{

    };

    TEST($project_name, Test_number_one){
        EXPECT_EQ(1, 1);
    }
}
    
EOF

echo "\nProcess completed. \nPlease, check the CMakeLists files and change the project name also the 'libproject' and 'project-test' values if you wish."

echo "\nTo build the project follow the steps below:"
echo "  1. cd $project_name/build"
echo "  2. cmake .."
echo "  3. make"
echo "  4. make test (alternatively you can execute the 'project-test' binary file in the $project_name/build/tests folder)"


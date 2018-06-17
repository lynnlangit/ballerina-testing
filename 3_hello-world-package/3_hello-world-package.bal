// to run a package
// 1. cd to TOP level directory `ballerina-testing', 
// 2. run `ballerina init` to initialize package structure (do this one time only)
// 3. run `ballerina run 3_hello-world-package/ to run all *.bal files in the package
// 4. test `ballerina run 3_hello-world-package/ to run all tests from all files in the package

// to run single file or single test file, 
// 1. cd to that directory `3_hello-world-package`
// 2. run `ballerina run 3_hello-world-package.bal` to run that file
// 3. test `ballerina test 3_hello-world-package-test.bal` to run all tests in the test file

import ballerina/io;

string greeting = "Hello, World!";

function main(string... args) {
    io:println(greeting);
}


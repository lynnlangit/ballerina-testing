// to run a package, cd to top level directory `ballerina-testing'
// run `ballerina run 3_hello-world-package/
// test `ballerina run 3_hello-world-package/

// to run single file or single test file, cd to that directory `3_hello-world-package`
// run `ballerina run 3_hello-world-package.bal`
// test `ballerina test 3_hello-world-package-test.bal`

import ballerina/io;

string greeting = "Hello, World!";

function main(string... args) {
    io:println(greeting);
}


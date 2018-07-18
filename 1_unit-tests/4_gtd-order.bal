// run via `ballerina test...` - it should fail

import ballerina/test;
import ballerina/io;

@test:Config {dependsOn: ["testFunction6"]}
function testFunction4() {
    io:println("I'm in test function 4!");
    test:assertTrue(true, msg = "Failed!");
}

@test:Config {dependsOn: ["testFunction4"]}
function testFunction5() {
    io:println("I'm in test function 5!");
    test:assertTrue(false, msg = "Failed!");
}

@test:Config
function testFunction6() {
    io:println("I'm in test function 6!");
    test:assertTrue(true, msg = "Failed!");
}
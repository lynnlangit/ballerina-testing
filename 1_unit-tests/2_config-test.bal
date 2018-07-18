// run via `ballerina test...` - it should fail

import ballerina/test;
import ballerina/io;

@test:Config {enable: true}
function testEnabled() {
    io:println("I'm an enabaled test");
    test:assertTrue(true, msg = "Failed!");
}

@test:Config {enable: false}
function testDisabled() {
    io:println("I'm a disabled test");
    test:assertTrue(false, msg = "Failed!");
}

@test:Config
function testNotMarked() {
    io:println("I'm the unmarked test");
    test:assertTrue(true, msg = "Failed!");
}
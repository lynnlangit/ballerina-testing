// run via `ballerina test...` - it should fail

import ballerina/test;
import ballerina/io;

@test:Mock { packageName: ".",functionName: "intAdd"}
public function mockIntAdd(int a, int b) returns (int) {
    io:println("I'm the mock function!");
    return (a - b);
}

@test:Config {}
function testAssertIntEquals() {
    int answer = 0;
    answer = intAdd(5, 3);
    io:println("Function mocking test");
    test:assertEquals(answer, 8, msg = "function mocking failed");
}

public function intAdd(int a, int b) returns (int) {
    return (a + b);
}
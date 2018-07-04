import ballerina/math;
import ballerina/io as console;
import ballerina/test;

@test:Mock {packageName: ".",functionName: "returnPi"}
public function mockReturnPi() returns (float) {
    console:println("I'm the mock function!");
    return math:PI;
}

@test:Config {}
function testAssertIntEquals() {
    float answer = 0;
    answer = returnPi( );
    console:println("Function mocking test");
    test:assertEquals(answer, math:PI, msg = "function mocking failed");
}

public function returnPi() returns (float) {

    float piValue = math:PI;
    return piValue;
    
}

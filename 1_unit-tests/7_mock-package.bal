import ballerina/math;
import ballerina/io as console;
import ballerina/test;

@test:Mock {packageName: ".",functionName: "returnPi"}
public function mockReturnPi() returns (float) {
    console:println("I'm the mock function!");
    return math:PI + 1.0;   // different and will fail (shows mocking)
}

@test:Config {}
function testAssertPiEquals() {
    float answer = 0;
    answer = returnPi( );
    console:println("Function mocking test");
    test:assertEquals(answer, math:PI, msg = "function mocking failed");
}

public function returnPi() returns (float) {

    float piValue = math:PI;
    return piValue;
    
}

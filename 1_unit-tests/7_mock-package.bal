// run via `ballerina test...` - it should fail

import ballerina/math as bmath;
import ballerina/io as console;
import ballerina/test;

@test:Mock {packageName: ".",functionName: "returnPi"}
public function mockReturnPi() returns (float) {
    console:println("I'm the mock function!");
    return bmath:PI + 1.0;   
}

@test:Config {}
function testAssertPiEquals() {
    float answer = 0;
    answer = returnPi( );
    console:println("Function mocking test");
    test:assertEquals(answer, bmath:PI, msg = "function mocking failed");
}

public function returnPi() returns (float) {

    float piValue = bmath:PI;
    return piValue;
    
}

// TDD - write the test and method stub
// run via `ballerina test...` - it should fail.
// update line 7 (string) to match line 14
// re-run test - it should pass.

import ballerina/test;

string greetingAct = "Hello, World!";

function sayHello(string... args) returns (string) {
    return greetingAct;
}

string greetingExp = "Hello, World TDD!";

@test:Config
function testSayHelloTDD() {
    string actual = sayHello(greetingAct);
    test:assertEquals(actual,greetingExp,msg="string test failed");
}


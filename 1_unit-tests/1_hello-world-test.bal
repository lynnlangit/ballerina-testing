import ballerina/test;

string greetingAct = "Hello, World !";
function sayHello(string... args) returns (string) {
    return greetingAct;
}

@test:Config
function testSayHelloTDD() {
    string actual = sayHello(greetingAct);
    string greetingExp = "Hello, World!";
    test:assertEquals(actual,greetingExp,msg="string test failed");
}


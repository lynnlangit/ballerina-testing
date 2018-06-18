import ballerina/io;
import ballerina/test;

string greeting = "Hello, World!";

function main(string... args) {
    io:println(greeting);
}

@test:Config
function testFunc() {
    main();
    test:assertEquals(greeting,"Hello, World!",msg="string test failed");
}

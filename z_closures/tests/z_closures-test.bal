

import ballerina/test;
import ballerina/io;

any[] outputs = [];
int counter = 0;

@test:Mock {packageName: "ballerina/io",functionName: "println"}
public function mockPrint(any... s) {
    outputs[counter] = s[0];
    counter++;
}

@test:Config {enable: true}
function testBasic() {
    main();
    test:assertEquals("Basic closure: 48", outputs[0]);
}

@test:Config {enable: false}
function testMulti() {
    main();
    test:assertEquals("Multilevel closure: 63", outputs[1]);
}

@test:Config
function testPointer() {
    main();
    test:assertEquals("Function pointers: 15", outputs[2]);
}
import ballerina/test;
import ballerina/io;

any[] outputs = [];
int counter = 0;

@test:Mock {
    packageName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any... s) {
    outputs[counter] = s[0];
    counter++;
}

@test:Config
function testFunc() {
    main();
    string out1 = "Event received; status: single, total occurrences: 2";
    test:assertEquals(out1, outputs[0]);
}

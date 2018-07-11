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
    // The output is in random order
    foreach x in outputs {
        string value = <string>x;
        if (value.equalsIgnoreCase("Hello, World! #m")) {
        } else if (value.equalsIgnoreCase("Hello, World! #n")) {
        } else if (value.equalsIgnoreCase("Hello, World! #k")) {
        }
        else {
            test:assertFail(msg = "The output doesn't contain the expected.");
        }
    }
}

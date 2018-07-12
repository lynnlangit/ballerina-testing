import ballerina/io;

// Invoke the function to start all workers automatically.
function main(string... args) {
    worker w1 {
        io:println("Hello, World! #w1");
    }

    worker w2 {
        io:println("Hello, World! #w2");
    }

    worker w3 {
        io:println("Hello, World! #w3");
    }
}

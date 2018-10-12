import ballerina/io;

// Invoke the function to start all workers automatically.
public function main(string... args) {
    worker w1 {
        io:println("Hello, World! #w4");
    }

    worker w2 {
        io:println("Hello, World! #w2");
    }

    worker w3 {
        io:println("Hello, World! #w3");
    }
}

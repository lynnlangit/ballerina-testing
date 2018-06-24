// Closure is an inner lambda function that has visibility to its enclosing environment's scope
// Closures can access variables values defined at global or their enclosing environment's scope

import ballerina/io;

int globalA = 5;

function basicClosure() returns (function (int) returns int) {
    int a = 3;
    // lambda with 'if' block accesses its outer scope variables
    var foo =  (int b) => int {
        int c = 34;
        if (b == 3) {
            c = c + b + a + globalA;
        }
        return c + a;
    };
    return foo;
}

function multilevelClosure() returns (function (int) returns int) {
    int a = 2;
    var func1 = (int x) => int {
        int b = 23;
        var func2 = (int y) => int {
            int c = 7;
            // innermost lambda has access to all of its outer scope variables
            var func3 = (int z) => int {
                return x + y + z + a + b + c;
            };
            return func3(8) + y + x;
        };
        return func2(4) + x;
    };
    return func1;
}

// Shows function pointers being passed around with closures
// Shows inner scope lambdas accessing outer scope variables
function functionPointers(int a) returns (function (int) returns (function (int) returns int)) {
    return (int b) => (function (int) returns int) {
        return (int c) => int {
            return a + b + c;
        };
    };
}

function main(string... args) {
  
    var foo = basicClosure();
    int result1 = foo(3);
    io:println("Basic closure: " + result1);

    var bar = multilevelClosure();
    int result2 = bar(5);
    io:println("Multilevel closure: " + result2);

    var baz1 = functionPointers(7);
    var baz2 = baz1(5);
    int result3 = baz2(3);
    io:println("Function pointers: " + result3);

}
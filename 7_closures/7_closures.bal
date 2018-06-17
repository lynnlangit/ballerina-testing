// In Ballerina, a closure is an inner lambda function that has visibility to 
// its enclosing environment's scope. It can access its own scope, its enclosing 
// environment's scope, and variables defined at the global scope.

import ballerina/io;

int globalA = 5;

// lambda with 'if' block accesses its outer scope variables
function basicClosure() returns (function (int) returns int) {
    int a = 3;
    var foo =  (int b) => int {
        int c = 34;
        if (b == 3) {
            c = c + b + a + globalA;
        }
        return c + a;
    };
    return foo;
}

// Example function with multiple levels of lambda functions in which the
// innermost lambda has access to all of its outer scope variables.
function multilevelClosure() returns (function (int) returns int) {
    int a = 2;
    var func1 = (int x) => int {
        int b = 23;
        var func2 = (int y) => int {
            int c = 7;
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
// Shows inner scope lambdas accessing  outer scope variables
function functionPointers(int a) returns
                    (function (int) returns (function (int) returns int)) {
    return (int b) => (function (int) returns int) {
        return (int c) => int {
            return a + b + c;
        };
    };
}

function main(string... args) {
  
    var foo = basicClosure();
    int result1 = foo(3);
    io:println("Answer basic closure: " + result1);

    var bar = multilevelClosure();
    int result2 = bar(5);
    io:println("Answer multilevel closure: " + result2);

    // shows how function pointers with closures are passed around
    var baz1 = functionPointers(7);
    var baz2 = baz1(5);
    int result3 = baz2(3);
    io:println("Answer function pointer: " + result3);

}
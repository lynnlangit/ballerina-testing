// run via `ballerina test...` - it should fail
// Invoke `curl http://localhost:9090/hello/sayHello`

import ballerina/io;
import ballerina/http;

service<http:Service> hello bind { port: 9090 } {

    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;
        res.setPayload("Hello, World!");

        caller->respond(res) but { error e => io:println(
                          "Error sending response") };
    }
}
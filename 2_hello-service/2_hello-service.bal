// To test as a package - cd to top level `ballerina-test`
// Test by `ballerina test 2_hello-service`
// Invoke `curl http://localhost:9090/hello/sayHello`

import ballerina/http;
import ballerina/log;

service hello on new http:Listener(9090) {
    resource function sayHello(http:Caller caller, http:Request req) {
        http:Response res = new;
        res.setPayload("Hello, World!");

        _ = caller->respond(res);
    }
}
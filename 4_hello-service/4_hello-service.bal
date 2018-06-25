// To test as a package - cd to top level `ballerina-test`
// Test by `ballerina test 4_hello-service`
// NOTE: Do NOT run the actual service, as you are using 'startService' & 'stopService'
// Invoke `curl http://localhost:9090/hello/sayHello`

import ballerina/http;
import ballerina/log;

service<http:Service> hello bind { port: 9090 } {

    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;
         res.setPayload("Hello, World!");

       caller->respond(res) but { error e => log:printError(
                           "Error sending response", err = e) };
    }
}
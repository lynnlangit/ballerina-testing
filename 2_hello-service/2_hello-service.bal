// To test as a package - cd to top level `ballerina-test`
// Test by `ballerina test 2_hello-service`
// NOTE: Do NOT run the actual service, as you are using 'startService' & 'stopService'
// Invoke `curl http://localhost:9097/hello/sayHello`
// Shows use of log for service response errors (rather than console)

import ballerina/http;
import ballerina/log;

service<http:Service> hello bind { port: 9097 } {

    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;
         res.setPayload("Hello, World !");

        caller->respond(res) but { error e => log:printError(
                           "Error sending response", err = e) };
    }
}
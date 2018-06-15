import ballerina/test;
import ballerina/io;
import ballerina/http;

boolean serviceStarted;

function startService() {serviceStarted = test:startServices("hello-world-service");}

@test:Config { before: "startService",after: "stopService" }
function testFunc() {
    endpoint http:Client httpEndpoint { url: "http://localhost:9090" };
    test:assertTrue(serviceStarted, msg = "Unable to start the service");

    string response1 = "Hello, World!";

    var response = httpEndpoint->get("/hello/sayHello");
    match response {
        http:Response resp => {
            var res = check resp.getTextPayload();
            test:assertEquals(res, response1);
        }
        error err => test:assertFail(msg = "Failed to call the endpoint:");
    }
}

function stopService() {
    test:stopServices("hello-world-service");
}
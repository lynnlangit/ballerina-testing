import ballerina/test;
import ballerina/io;
import ballerina/http;

@test:Config 
function testFunc() {
    endpoint http:Client httpEndpoint { url: "http://localhost:9090" };
    string response1 = "Hello, World !";
    var response = httpEndpoint->get("/hello/sayHello");
    match response {
        http:Response resp => {
            var res = check resp.getTextPayload();
            test:assertEquals(res, response1);
        }
        error err => test:assertFail(msg = "Failed to call the endpoint:");
    }
}

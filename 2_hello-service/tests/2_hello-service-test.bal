import ballerina/test;
import ballerina/io;
import ballerina/http;
import ballerina/log;

public function main() {
    http:Client clientEP = new("http://localhost:9090");
    var resp = clientEP->get("/hello/sayHello");
    if (resp is http:Response) {
        var payload = resp.getTextPayload();
        if (payload is string) {
            log:printInfo(payload);
        } else {
            log:printError(<string> payload.detail().message);
        }
    } else {
        log:printError(<string> resp.detail().message);
    }
}

// @test:Config 
//  function testFunc() {
//      endpoint http:Client httpEndpoint { 
//          url: "http://localhost:9090" };
//     string response1 = "Hello, World !";
//     var response = httpEndpoint->get("/hello/sayHello");
//     match response {
//         response => {
//             var res = check resp.getTextPayload();
//             test:assertEquals(res, response1);
//         }
//         _ => test:assertFail(msg = "Failed to call the endpoint:");
//     }
// }

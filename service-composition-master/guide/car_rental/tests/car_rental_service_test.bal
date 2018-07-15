import ballerina/test;
import ballerina/http;

@test:BeforeSuite
function beforeFunc() {
    _ = test:startServices("car_rental");
}

endpoint http:Client clientEP {
    url:"http://localhost:9093/car"
};

@test:Config
function testCarRentalService() {
    json payload = {
        "Name":"Lynn",
        "ArrivalDate":"12-03-2018",
        "DepartureDate":"13-04-2018",
        "Preference":"Air Conditioned"
    };

    http:Response response = check clientEP -> post("/rent", payload);
    test:assertEquals(response.statusCode, 200, msg = "Car rental service did not respond with 200 OK signal!");
    json resPayload = check response.getJsonPayload();
    json expected = {"Status":"Success"};
    test:assertEquals(resPayload, expected, msg = "Response mismatch!");
}

@test:AfterSuite
function afterFunc() {
    test:stopServices("car_rental");
}

import ballerina/test;
import ballerina/http;

@test:BeforeSuite
function beforeFunc() {
    _ = test:startServices("airline_reservation");
}

endpoint http:Client clientEP {
    url:"http://localhost:9091/airline"
};

@test:Config
function testAirlineReservationService() {
    json payload = {
        "Name":"Alice",
        "ArrivalDate":"12-03-2018",
        "DepartureDate":"13-04-2018",
        "Preference":"Business"
    };

    http:Response response = check clientEP -> post("/reserve", payload);
    test:assertEquals(response.statusCode, 200,
        msg = "Airline reservation service did not respond with 200 OK signal!");
    json resPayload = check response.getJsonPayload();
    json expected = {"Status":"Success"};
    test:assertEquals(resPayload, expected, msg = "Response mismatch!");
}

@test:AfterSuite
function afterFunc() {
    test:stopServices("airline_reservation");
}

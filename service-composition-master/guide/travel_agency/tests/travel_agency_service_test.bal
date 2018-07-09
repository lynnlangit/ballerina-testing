// this test currently fails, regression bug being addressed by the team

import ballerina/test;
import ballerina/http;

@test:BeforeSuite
function beforeFunc() {
   
    _ = test:startServices("travel_agency");
    _ = test:startServices("airline_reservation");
    _ = test:startServices("hotel_reservation");
    _ = test:startServices("car_rental");
}

endpoint http:Client clientEP {
    url:"http://localhost:9090/travel"
};

@test:Config
function testTravelAgencyService() {

    http:Request req;
    json payload = {
        "Name":"Alice",
        "ArrivalDate":"12-03-2018",
        "DepartureDate":"13-04-2018",
        "Preference":{"Airline":"Business", "Accommodation":"Air Conditioned", "Car":"Air Conditioned"}
    };

    http:Response response = check clientEP -> post("/arrangeTour", payload);
    test:assertEquals(response.statusCode, 200, msg = "Travel agency service did not respond with 200 OK signal!");
    json resPayload = check response.getJsonPayload();
    json expected = {"Message":"Congratulations! Your journey is ready!!"};
    test:assertEquals(resPayload, expected, msg = "Response mismatch!");
}

@test:AfterSuite
function afterFunc() {
  
    test:stopServices("travel_agency");
    test:stopServices("airline_reservation");
    test:stopServices("hotel_reservation");
    test:stopServices("car_rental");
}

import ballerina/http;
//import ballerinax/docker;
//import ballerinax/kubernetes;

//@docker:Config {
//    registry:"ballerina.guides.io",
//    name:"travel_agency_service",
//    tag:"v1.0"
//}
//
//@docker:Expose{}

//@kubernetes:Ingress {
//  hostname:"ballerina.guides.io",
//  name:"ballerina-guides-travel-agency-service",
//  path:"/"
//}
//
//@kubernetes:Service {
//  serviceType:"NodePort",
//  name:"ballerina-guides-travel-agency-service"
//}
//
//@kubernetes:Deployment {
//  image:"ballerina.guides.io/travel_agency_service:v1.0",
//  name:"ballerina-guides-travel-agency-service"
//}


endpoint http:Listener travelAgencyEP {port:9098};
endpoint http:Client airlineReservationEP {url:"http://localhost:9091/airline"};
endpoint http:Client hotelReservationEP {url:"http://localhost:9092/hotel"};
endpoint http:Client carRentalEP {url:"http://localhost:9093/car"};

@http:ServiceConfig {basePath:"/travel"}
service<http:Service> travelAgencyService bind travelAgencyEP {

    @http:ResourceConfig {methods:["POST"], consumes:["application/json"], produces:["application/json"]}
    arrangeTour(endpoint client, http:Request inRequest) {
        http:Response outResponse;
        json inReqPayload;
        json outReqPayload = {"Name":"", "ArrivalDate":"", "DepartureDate":"", "Preference":""};

        match inRequest.getJsonPayload() {
            json payload => inReqPayload = payload;
            any => {
                outResponse.statusCode = 400;
                outResponse.setJsonPayload({"Message":"Invalid payload - Not a valid JSON payload"});
                _ = client -> respond(outResponse);
                done;
            }
        }

        outReqPayload.Name = inReqPayload.Name;
        outReqPayload.ArrivalDate = inReqPayload.ArrivalDate;
        outReqPayload.DepartureDate = inReqPayload.DepartureDate;
        json airlinePreference = inReqPayload.Preference.Airline;
        json hotelPreference = inReqPayload.Preference.Accommodation;
        json carPreference = inReqPayload.Preference.Car;

        if (outReqPayload.Name == null || outReqPayload.ArrivalDate == null || outReqPayload.DepartureDate == null ||
            airlinePreference == null || hotelPreference == null || carPreference == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = client -> respond(outResponse);
            done;
        }

        json outReqPayloadAirline = outReqPayload;
        outReqPayloadAirline.Preference = airlinePreference;

        http:Response inResAirline = check airlineReservationEP -> post("/reserve", untaint outReqPayloadAirline);

        var airlineResPayload = check inResAirline.getJsonPayload();
        string airlineStatus = airlineResPayload.Status.toString();
        if (airlineStatus.equalsIgnoreCase("Failed")) {
            outResponse.setJsonPayload({"Message":"Failed to reserve airline! " +
                    "Provide a valid 'Preference' for 'Airline' and try again"});
            _ = client -> respond(outResponse);
            done;
        }

        json outReqPayloadHotel = outReqPayload;
        outReqPayloadHotel.Preference = hotelPreference;

        http:Response inResHotel = check hotelReservationEP -> post("/reserve", untaint outReqPayloadHotel);

        var hotelResPayload = check inResHotel.getJsonPayload();
        string hotelStatus = hotelResPayload.Status.toString();
        if (hotelStatus.equalsIgnoreCase("Failed")) {
            outResponse.setJsonPayload({"Message":"Failed to reserve hotel! " +
                    "Provide a valid 'Preference' for 'Accommodation' and try again"});
            _ = client -> respond(outResponse);
            done;
        }

        json outReqPayloadCar = outReqPayload;
        outReqPayloadCar.Preference = carPreference;

        http:Response inResCar = check carRentalEP -> post("/rent", untaint outReqPayloadCar);

        var carResPayload = check inResCar.getJsonPayload();
        string carRentalStatus = carResPayload.Status.toString();
        if (carRentalStatus.equalsIgnoreCase("Failed")) {
            outResponse.setJsonPayload({"Message":"Failed to rent car! " +
                    "Provide a valid 'Preference' for 'Car' and try again"});
            _ = client -> respond(outResponse);
            done;
        }

        outResponse.setJsonPayload({"Message":"Congratulations! Your journey is ready!!"});
        _ = client -> respond(outResponse);
    }
}
import ballerina/http;
//import ballerinax/docker;
//import ballerinax/kubernetes;

//@docker:Config {
//    registry:"ballerina.guides.io",
//    name:"airline_reservation_service",
//    tag:"v1.0"
//}
//
//@docker:Expose{}

//@kubernetes:Ingress {
//  hostname:"ballerina.guides.io",
//  name:"ballerina-guides-airline-reservation-service",
//  path:"/"
//}
//
//@kubernetes:Service {
//  serviceType:"NodePort",
//  name:"ballerina-guides-airline-reservation-service"
//}
//
//@kubernetes:Deployment {
//  image:"ballerina.guides.io/airline_reservation_service:v1.0",
//  name:"ballerina-guides-airline-reservation-service"
//}

endpoint http:Listener airlineEP {
    port:9091
};

@final string ECONOMY = "Economy";
@final string BUSINESS = "Business";
@final string FIRST = "First";


@http:ServiceConfig {basePath:"/airline"}
service<http:Service> airlineReservationService bind airlineEP {

    @http:ResourceConfig {methods:["POST"], path:"/reserve", consumes:["application/json"],
        produces:["application/json"]}
    reserveTicket(endpoint client, http:Request request) {
        http:Response response;
        json reqPayload;

        match request.getJsonPayload() {
            json payload => reqPayload = payload;
            any => {
                response.statusCode = 400;
                response.setJsonPayload({"Message":"Invalid payload - Not a valid JSON payload"});
                _ = client -> respond(response);
                done;
            }
        }

        json name = reqPayload.Name;
        json arrivalDate = reqPayload.ArrivalDate;
        json departDate = reqPayload.DepartureDate;
        json preferredClass = reqPayload.Preference;

        if (name == null || arrivalDate == null || departDate == null || preferredClass == null) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = client -> respond(response);
            done;
        }

        string preferredClassStr = preferredClass.toString();
        if (preferredClassStr.equalsIgnoreCase(ECONOMY) || preferredClassStr.equalsIgnoreCase(BUSINESS) ||
            preferredClassStr.equalsIgnoreCase(FIRST)) {
            response.setJsonPayload({"Status":"Success"});
        }
        else {
            response.setJsonPayload({"Status":"Failed"});
        }
        _ = client -> respond(response);
    }
}

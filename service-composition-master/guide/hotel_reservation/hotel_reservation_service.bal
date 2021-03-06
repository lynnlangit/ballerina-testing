import ballerina/http;
//import ballerinax/docker;
//import ballerinax/kubernetes;

//@docker:Config {
//    registry:"ballerina.guides.io",
//    name:"hotel_reservation_service",
//    tag:"v1.0"
//}
//
//@docker:Expose{}

//@kubernetes:Ingress {
//  hostname:"ballerina.guides.io",
//  name:"ballerina-guides-hotel-reservation-service",
//  path:"/"
//}
//
//@kubernetes:Service {
//  serviceType:"NodePort",
//  name:"ballerina-guides-hotel-reservation-service"
//}
//
//@kubernetes:Deployment {
//  image:"ballerina.guides.io/hotel_reservation_service:v1.0",
//  name:"ballerina-guides-hotel-reservation-service"
//}

endpoint http:Listener hotelEP {port:9092};

@final string AC = "Air Conditioned";
@final string NORMAL = "Normal";

@http:ServiceConfig {basePath:"/hotel"}
service<http:Service> hotelReservationService bind hotelEP {

    @http:ResourceConfig {methods:["POST"], path:"/reserve", consumes:["application/json"],
        produces:["application/json"]}
    reserveRoom(endpoint client, http:Request request) {
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
        json preferredRoomType = reqPayload.Preference;

        if (name == null || arrivalDate == null || departDate == null || preferredRoomType == null) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = client -> respond(response);
            done;
        }

        string preferredTypeStr = preferredRoomType.toString();
        if (preferredTypeStr.equalsIgnoreCase(AC) || preferredTypeStr.equalsIgnoreCase(NORMAL)) {
            response.setJsonPayload({"Status":"Success"});
        }
        else {
            response.setJsonPayload({"Status":"Failed"});
        }
        _ = client -> respond(response);
    }
}

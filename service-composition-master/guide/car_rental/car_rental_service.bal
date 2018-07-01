import ballerina/http;
//import ballerinax/docker;
//import ballerinax/kubernetes;

//@docker:Config {
//    registry:"ballerina.guides.io",
//    name:"car_rental_service",
//    tag:"v1.0"
//}
//
//@docker:Expose{}

//@kubernetes:Ingress {
//  hostname:"ballerina.guides.io",
//  name:"ballerina-guides-car-rental-service",
//  path:"/"
//}
//
//@kubernetes:Service {
//  serviceType:"NodePort",
//  name:"ballerina-guides-car-rental-service"
//}
//
//@kubernetes:Deployment {
//  image:"ballerina.guides.io/car_rental_service:v1.0",
//  name:"ballerina-guides-car-rental-service"
//}

// Service endpoint
endpoint http:Listener carEP {
    port:9093
};

// Available car types
@final string AC = "Air Conditioned";
@final string NORMAL = "Normal";

// Car rental service to rent cars
@http:ServiceConfig {basePath:"/car"}
service<http:Service> carRentalService bind carEP {

    // Resource to rent a car
    @http:ResourceConfig {methods:["POST"], path:"/rent", consumes:["application/json"], produces:["application/json"]}
    rentCar(endpoint client, http:Request request) {
        http:Response response;
        json reqPayload;

        // Try parsing the JSON payload from the request
        match request.getJsonPayload() {
            // Valid JSON payload
            json payload => reqPayload = payload;
            // NOT a valid JSON payload
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
        json preferredType = reqPayload.Preference;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (name == null || arrivalDate == null || departDate == null || preferredType == null) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = client -> respond(response);
            done;
        }

        // Mock logic
        // If request is for an available car type, send a rental successful status
        string preferredTypeStr = preferredType.toString();
        if (preferredTypeStr.equalsIgnoreCase(AC) || preferredTypeStr.equalsIgnoreCase(NORMAL)) {
            response.setJsonPayload({"Status":"Success"});
        }
        else {
            // If request is not for an available car type, send a rental failure status
            response.setJsonPayload({"Status":"Failed"});
        }
        // Send the response
        _ = client -> respond(response);
    }
}

// from https://ballerina.io/learn/by-guide/ballerina-with-istio/
// to run `ballerina run time_service.bal`
// to invoke `curl localhost:9095/localTime`

import ballerina/http;
import ballerina/io;
import ballerina/time;

endpoint http:Listener listener {port:9095};

@http:ServiceConfig {basePath:"/localtime"}
service<http:Service> time bind listener {

    @http:ResourceConfig{path: "/",  methods: ["GET"]}
    getTime (endpoint caller, http:Request request) {
        
        http:Response response = new;
        time:Time currentTime = time:currentTime();
        string customTimeString = currentTime.format("yyyy-MM-dd'T'HH:mm:ss");
        json timeJ = {currentTime : customTimeString };
        response.setJsonPayload(timeJ);
        _ = caller -> respond(response);
    }
}

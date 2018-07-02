import ballerina/http;
import ballerinax/docker;

@docker:Config {
   //registry:"ballerina.guides.io",
   //name:"hello_docker",
   //tag:"v1.0"
}

@docker:Expose{}

@http:ServiceConfig {basePath:"/helloDocker"}
service<http:Service> helloDocker bind {port:9090} {
    sayHello(endpoint outboundEP, http:Request request) {
        http:Response response = new;
        response.setTextPayload("Hello, Docker from service helloDocker ! \n");
        _ = outboundEP->respond(response);
    }
}
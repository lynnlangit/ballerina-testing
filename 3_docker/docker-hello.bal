import ballerina/http;
//import ballerinax/docker;

//@docker:Expose{}
endpoint http:Listener helloWorldEP {port:9095};

 //@docker:Config {
 //    registry:"docker.abc.com",
 //    name:"helloworld",
 //    tag:"v1.0"
 //}
@http:ServiceConfig {basePath:"/helloWorld"}
service<http:Service> helloWorld bind helloWorldEP {
    sayHello (endpoint outboundEP, http:Request request) {
        http:Response response = new;
        response.setTextPayload("Hello, World from service helloWorld ! \n");
        _ = outboundEP -> respond(response);
    }
}
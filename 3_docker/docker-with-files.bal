// build .bal, run docker file, then curl
// invoke `curl http://localhost:9096/helloWorldFiles/data`
// invoke `curl http://localhost:9096/helloWorldFiles/config/tyler` | lynn

import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerinax/docker;

@docker:Config {}
@docker:CopyFiles {
    files:[
        {source:"./conf/ballerina.conf", target:"/home/ballerina/conf/ballerina.conf", isBallerinaConf:true},
        {source:"./conf/data.txt", target:"/home/ballerina/data/data.txt"}
    ]
}

@docker:Expose {}
endpoint http:Listener helloWorldFEP { port:9096};

@http:ServiceConfig {basePath:"/helloWorldFiles"}
service<http:Service> helloWorldFiles bind helloWorldFEP {

    @http:ResourceConfig {methods:["GET"],path:"/config/{user}"}
    getConfig(endpoint outboundEP, http:Request request, string user) {
        http:Response response = new;
        string userId = getConfigValue(user, "userid");
        string groups = getConfigValue(user, "groups");
        string payload = "{'userId': '" + userId + "', 'groups': '" + groups + "'}";
        response.setTextPayload(payload + "\n");
        _ = outboundEP->respond(response);
    }

    @http:ResourceConfig { methods:["GET"],path:"/data"}
    getData(endpoint outboundEP, http:Request request) {
        http:Response response = new;
        string payload = readFile("./data/data.txt");
        response.setTextPayload("{'data': '" + untaint payload + "'}\n");
        _ = outboundEP->respond(response);
    }
}

function getConfigValue(string instanceId, string property) returns (string) {
    string key = untaint instanceId + "." + untaint property;
    return config:getAsString(key, default = "Invalid User");
}

function readFile(string filePath) returns (string) {
    io:Mode permission = "r";
    io:ByteChannel bchannel = io:openFile(filePath, permission);
    io:CharacterChannel myChannel = new io:CharacterChannel(bchannel, "UTF-8");

    var readOutput = myChannel.read(100);
    match readOutput {
        string text => {
            return text;
        }
        error ioError => return "Error: Unable to read file";
    }
}

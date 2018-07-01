import ballerina/config;
import ballerina/http;
import ballerina/io;
import wso2/github4;

function main(string... args) {
    endpoint github4:Client githubClient {
        clientConfig: {
            auth:{
                scheme:http:OAUTH2,
                accessToken:config:getAsString("GITHUB_TOKEN")
            }
        }
    };

    github4:Repository repository = {};
    var repo = githubClient->getRepository("lynnlangit/TeamTeri");
    match repo {
        github4:Repository rep => {
            repository = rep;
        }
        github4:GitClientError err => {
            io:println(err);
        }
    }

    io:println(repository);
}

// M2 
// Pull code and / or English (comments) from my GitHub Repos
// Sort and filter for interest

// M3
// Connect to GCP ML (OAuth / token) for text analytics
// Write Ballerina package - test it
// Prepare package for push to Ballerina Central - test it

// M4
// Connect to AWS ML (OAuth / token) for text analytics
// Write Ballerina package - test it
// Prepare package for push to Ballerina Central - test it


// Compare this to GCP BigQuery
// Full dataset available to GCP (but it's a bit stale)
// Cost to query
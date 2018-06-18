import wso2/github4;
import ballerina/io;
import ballerina/config;

// app idea -- analyze text sentiment of my GitHub code
// use Ballerina GitHub package to retrieve data - https://central.ballerina.io/wso2/github4
// use GCP ML Text analysis (write a Ballerina package? push to Ballerina Central?)
// use AWS ML Text analysis (write a Ballerina package?  "")

// M1: Pull and use Ballerina GitHub package, i.e. "Hello GitHub"
function main (string[] args) {
        endpoint github4:Client githubClient {
            clientConfig: {
                auth: {
                    scheme:"oauth",
                    accessToken:config:getAsString("GITHUB_TOKEN")
                }
            }   
        };
    
        github4:Repository repository = {};
        var repo = githubClient -> getRepository("lynnlangit/TeamTeri");
        match repo {
            github4:Repository rep => {repository = rep;}
            github4:GitClientError err => {io:println(err);}
        }
        io:println(repository);
    }
    
//      return info about my Repo

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
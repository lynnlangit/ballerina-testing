// types of "service -> deploy to Docker" tests

// 1. Functional test - Can you hit the endpoint and get the correct result?
// curl http://localhost:9090/helloWorldFiles/data

// 2. Configuration test - Is the configuration (docker) file the same as 'last known good'?
// //ToDo - test 'golden master' of DockerFile

// 3. Are external dependency call results the same? i.e. does file string value match 'last known good'
// Verify version number of ballerinax/docker library?

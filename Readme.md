# Ballerina Language Unit Tests

The Repo shows code examples for writing & running Ballerina Language unit tests.  An example of testing a Ballerina service is shown below.

![test service](/images/test-service.png)

### Ballerina Testing Concepts

There are several language principals and capabilities built into Ballerina Language which support testing.  They include the following:

 - **File or Folder** -  programmers can either place their test code into a single source code file or in a tests folder inside a project directory structure
 - **Annotations** -  tests are defined using a set of annotations. Test assertions can be used to verify the set of program behaviour expectations
 - **Services Skeletons** - service calls can be tested using service skeletons in the test phase of the project until the system is connected to real service
 - **Function mocks** -  can be used to mimic third party function calls to enable testing a project package in isolation
 - **Data providers** -  can be used to feed in the test data sets

 ### How to Test in Ballerina

 Start by importing the Ballerina test package.  This step is required for all test scenarios.  Then add the @test:[value] decorator to your test function. 

    import ballerina/test; 

    @test:Config
    function testFunc() {
        main();
        test:assertEquals(greeting,"Hello, World!",msg="failed");
    }

 There are a number of ways to write and run tests.  They are as follows:

 1. Use one file for tests and program code  
  - Run the program code using `ballerina run [filename.bal]`   
  - Run the tests using `ballerina test [filname.bal]` from that directory.

 2. Write test files in a `\tests` folder below the folder that holds the program code for integration scenarios. 
  - Run `ballerina init...` from the top folder  
  - Run `ballerina test [folderName]` to run all tests in that package.  The folder name is the package name.  
  - Include an optional `\resources` folder at this level to include resource files.

 -----

 ### Ballernia General Language Tips

 There are a number of common commands which can be useful during the development process in Ballerina.  These include the following:

- `which ballerina` - shows the path to the installation
- `ballerina -v` - shows the running version
- `ballerina init` - creates package structure, run from top level folder
- `ballerina run [fileName.bal]` - runs *.bal files & services in file
- `ballerina test [fileName-test.bal]`- runs *.bal tests in file
- `ballerina run [package]` - runs *.bal files and services in folder
- `ballerina test [package]`- runs *.bal tests in folder
- `ballerina build [package]` - builds *.bal files in folder to *.balx, also creates Docker/Kubernetes files if services 
are annotated
- `ballerina search [external service name]` - searches Ballerina Central Repository for external packages, i.e. 'github'
- `ballerina pull [external service name]` - copies external package code into local instance
- `composer` - opens local instance of Ballerina Composer IDE


-------

 For more information - see [how to test in Ballerina](https://ballerina.io/learn/how-to-test-ballerina-code/index.html)
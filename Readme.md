# Ballerina Language Unit Tests

The Repo shows code examples for writing & running Ballerina Language unit tests.  An example of testing a Ballerina service is shown below.  These code examples run with Ballerina Language version - RC 0.980.0 (Jul 10, 2018).


![test service](/images/test-service.png)  

**IMPORTANT** the majority of test examples in this Repo are set to FAIL, this is by design and for demonstration purposes.

---

## How to Test in Ballerina

 Start by importing the Ballerina test package.  This step is required for all test scenarios.  Then add the @test:[value] decorator to your test function. 

    import ballerina/test; 

    @test:Config
    function testFunc() {
        main();
        test:assertEquals(greeting,"Hello, World!",msg="failed");
    }

 There are two ways to write and run tests.  They are as follows:

 1. Use one file for tests and program code  
    - Run the program code using `ballerina run [filename.bal]`   
    - Run the tests using `ballerina test [filname.bal]` from that directory.

 2. Write test files in a `\tests` folder below the folder that holds the program code for integration scenarios. 
    - Run `ballerina init...` from the top folder  
    - Run `ballerina test [folderName]` to run all tests in that package.  The folder name is the package name.  
    - Include an optional `\resources` folder at this level to include resource files.

 -----

 ## Ballerina Language Tips

 There are a number of common commands which can be useful during the development process in Ballerina.  These include the following:
- Setup
    - `which ballerina` - shows the path to the installation
    - `ballerina -v` - shows the running version
    - `ballerina init` - creates package structure, run from top level folder  

- Running Services or Tests  
    - `ballerina run [fileName.bal]` - runs *.bal files & services in file
    - `ballerina test [fileName-test.bal]`- runs *.bal tests in file
    - `ballerina run [package]` - runs *.bal files and services in folder
    - `ballerina test [package]`- runs *.bal tests in folder
- Working with Packages
    - `ballerina build [package]` - builds *.bal files in folder to *.balx, also creates Docker/Kubernetes files if services 
are annotated
    - `ballerina search [external service name]` - searches Ballerina Central Repository for external packages, i.e. 'github'
    - `ballerina pull [external service name]` - copies external package code into local instance

- Tools
    - `ballerina.vsix` - plug in for VSCode
    - `composer` - opens local instance of Ballerina Composer IDE


-------

 For more information - see [how to test in Ballerina](https://ballerina.io/learn/how-to-test-ballerina-code/index.html)
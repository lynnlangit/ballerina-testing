## Ballerina Unit Tests

The Repo shows code examples for writing and running Ballerina Language unit tests.

### Testing In Ballerina

There are several language principals and capabilities built into Ballerina Language which support testing.  They include the following:

 - Ballerina programmers can either place their test code into a single source code file or in a tests folder inside a project directory structure

 - Ballerina tests are defined using a set of annotations

 - Test assertions can be used to verify the set of program behaviour expectations

 - Data providers can be used to feed in the test data sets

 - Service calls can be tested using service skeletons in the test phase of the project until the system is connected to real service

 - Function mocks can be used to mimic third party function calls to enable testing a project package in isolation

 ### How to Test in Ballerina

 There are several considerations when testing in Ballerina.  Start by importing the Ballerina test package.  This step is required for all test scenarios. 

    `import ballerina/test;`  

 There are a number of ways to write and run tests.  They are as follows:

 1. Write tests in the same source file alongside the program code.  Run the program code using `ballerina run....` and run the tests using `ballerina test...` from that directory.

 2. Write test files in a `\tests` folder underneath the a folder for that holds the program code. Run `ballerina init...` from the top folder, then run `ballerina test [folderName]` to run all tests in that package.  The folder name is the package name.

 3. Write tests in the project root level folder `\tests` for integration scenarios.  You can also include a `\resources` folder at this level to include resource files.

 For more information - https://ballerina.io/learn/how-to-test-ballerina-code/index.html#service-startstop-utility
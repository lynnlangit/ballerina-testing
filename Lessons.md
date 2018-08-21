# Ballerina Language Learning Lessons Code 

1. Define Goal - Hello Ballerina
 - Verify language from command prompt
 - Verify editor and plug in VSCode
 - Read Code "HelloWorld"
 - Run Code
 - Run a Test "HelloWorldTest"
 - Make the Test pass

2. Define Goal - Hello Ballerina Service
 - Read Code "HelloWorldService"
 - Run Code
 - Run Test "HelloWorldServiceTest"
 - Make the Test pass

3. - Define Goal - Hello Ballerina Docker Service
 - Read Code "HelloWorldService"
 - Run Code and Test it
 - Show Docker plug in
 - Add Docker annotation
 - Start Docker Service
 - <Remote> Test Service running Docker using 'curl...'


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
    - `ballerina list` - shows files in package tree
are annotated
    - `ballerina search [external service name]` - searches Ballerina Central Repository for external packages, i.e. 'github'
    - `ballerina pull [external service name]` - copies external package code into local instance

- Tools
    - `ballerina.vsix` - plug in for VSCode
    - `composer` - opens local instance of Ballerina Composer IDE


-------

 For more information - see [how to test in Ballerina](https://ballerina.io/learn/how-to-test-ballerina-code/index.html)
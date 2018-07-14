import ballerina/io;
import ballerina/runtime;

type StatusCount record {
    string status;
    int totalCount;
};

type Teacher record {
    string name;
    int age;
    string status;
    string batch;
    string school;
};

function testAggregationQuery(
    stream<StatusCount> filteredStatusCountStream,
    stream<Teacher> teacherStream) {
    // Create a forever statement block with an appropriate streaming query.
    //  Write a query to filter teachers who are older than 18 years, wait for the stream to collect three teacher
    //      objects, group the 3 teachers based on their marital status, and then obtain the 
    //      unique marital status counts.
    // Once the query is executed, publish the result to the `filteredStatusCountStream` stream.
    forever {
        from teacherStream where age > 18 window lengthBatch(3)
        select status, count(status) as totalCount
        group by status
        having totalCount > 1
        => (StatusCount[] status) {
            filteredStatusCountStream.publish(status);
        }
    }
}

function main(string... args) {

    // Create two streams - constrained by `StatusCount`& `Teacher` record types.
    stream<StatusCount> filteredStatusCountStream;
    stream<Teacher> teacherStream;

    //Invoke the method that contains the forever streaming statement.
    testAggregationQuery(filteredStatusCountStream, teacherStream);

    // Create sample events, and send the events to the `teacherStream` input stream.
    Teacher t1 = {name: "Matt", age: 38, status: "single",
        batch: "LK2014", school: "Higher Grounds"};
    Teacher t2 = {name: "David", age: 51, status: "SINGLE",
        batch: "LK1998", school: "Moreno Valley Middle"};
    Teacher t3 = {name: "Doug", age: 35, status: "married",
        batch: "LK1988", school: "Le Port Middle"};

    // Subscribe the `filteredStatusCountStream` stream to the `printStatusCount` function. 
    //  Each time the stream receives an event, call the `printStatusCount` function.
    filteredStatusCountStream.subscribe(printStatusCount);

    teacherStream.publish(t1);
    teacherStream.publish(t2);
    teacherStream.publish(t3);

    runtime:sleep(1000);
}

function printStatusCount(StatusCount s) {
    io:println("Event received; status: " + s.status +
            ", total occurrences: " + s.totalCount);
}



import shan1024/chalk;
import ballerina/io;

function main(string... args) {

    chalk:Chalk chalk = new(chalk:WHITE, chalk:RED);
    string colorizedText = chalk.write("Hello world !!!");
    io:println(colorizedText);
    
    // chalk:Chalk chalk = new(chalk:WHITE, chalk:RED, italicize = true, underline = true);
    // string colorizedText = chalk.dark().italicize().reverse().write("Hello world !!!");
    // io:println(colorizedText);
}
import ballerina/io;

public function main(string... args) {
    foreach int n in int:range(-10, 11, 1) {
        int numSpaces = int:abs(n);
        int numStars = 21 - 2 * numSpaces;
        io:println("".padEnd(numSpaces, " ") + "".padEnd(numStars, "*"));
    }
}

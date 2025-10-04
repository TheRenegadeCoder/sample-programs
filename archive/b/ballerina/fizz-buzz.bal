import ballerina/io;

public function main() {
	foreach int i in int:range(1, 101, 1) {
		if i % 15 == 0 {
			io:println("FizzBuzz");
		} else if i % 5 == 0 {
			io:println("Buzz");
		} else if i % 3 == 0 {
			io:println("Fizz");
		} else {
			io:println(i);
		}
	}
}

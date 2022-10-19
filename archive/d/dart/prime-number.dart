import 'dart:io';

bool isPrime(Input) {
    for (var i = 2; i <= Input / i; ++i) {
        if (Input % i == 0) {
            return false;
        }
    }
    return true;
}

void main() {
    print('Enter N');
    var Input = int.parse(stdin.readLineSync());
    if(!Input.isNegative) {
        isPrime(Input)?print('$Input is a prime number.'):print('$Input is not a prime number.');
    } else {
        print("Input ($Input) should not be negative");
    }
}

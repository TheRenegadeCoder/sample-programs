---
title: fractions in C++
layout: default
last-modified: 2019-10-10
featured-image:
tags: [c-plus-plus, fractions]
authors:
  - niraj-kamdar
---

Welcome to another addition to the Sample Programs in Every Language collection.
Today, we'll be tackling fractions in C++.

## How to Implement the Solution

Let's first take a look at the solution.

```c++
#include<iostream>
#include<string>
using namespace std;

int gcd(int a, int b){
    if(a<0){
        a = -a;
    }
    while(a%b != 0){
        int i = a;
        int j = b;
        a = j;
        b = i%j;
    }
    return b;
}

class Fraction{
private:
    int numerator;
    int denomenator;

public:

    Fraction(int top=0, int bottom=1){
        if(bottom < 0){
            top = -top;
        }
        else if(bottom == 0){
            throw "Error: Denomenator can't be zero.";
        }
        int hcf = gcd(top, bottom);
        numerator = top/hcf;
        denomenator = bottom/hcf;
    }

    Fraction operator -(){
        int top = -numerator;
        int bottom = denomenator;
        return Fraction(top, bottom);
    }

    int getnumerator(){
        return numerator;
    }

    int getdenometor(){
        return denomenator;
    }

    friend ostream &operator << (ostream &stream, const Fraction &frac);
    friend Fraction operator +(const Fraction f1, const Fraction f2);
    friend Fraction operator +(const Fraction f1, const int f2);
    friend Fraction operator +(const int f1, const Fraction f2);
    friend Fraction operator +=(const Fraction f1, const Fraction f2);
    friend Fraction operator -(const Fraction f1, const Fraction f2);
    friend Fraction operator -(const Fraction f1, const int f2);
    friend Fraction operator -(const int f1, const Fraction f2);
    friend Fraction operator -=(const Fraction f1, const Fraction f2);
    friend Fraction operator *(const Fraction f1, const Fraction f2);
    friend Fraction operator *(const Fraction f1, const int f2);
    friend Fraction operator *(const int f1, const Fraction f2);
    friend Fraction operator *=(const Fraction f1, const Fraction f2);
    friend Fraction operator /(const Fraction f1, const Fraction f2);
    friend Fraction operator /(const Fraction f1, const int f2);
    friend Fraction operator /(const int f1, const Fraction f2);
    friend Fraction operator /=(const Fraction f1, const Fraction f2);
    friend bool  operator ==(const Fraction f1, const Fraction f2);
    friend bool  operator <(const Fraction f1, const Fraction f2);
    friend bool  operator >(const Fraction f1, const Fraction f2);
    friend bool operator !=(const Fraction f1, const Fraction f2);
    friend bool operator <=(const Fraction f1, const Fraction f2);
    friend bool operator >=(const Fraction f1, const Fraction f2);


};

ostream &operator <<(ostream &stream, const Fraction &frac){
    stream << frac.numerator << "/" << frac.denomenator;
    return stream;
}

Fraction operator +(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.denomenator + f2.numerator*f1.denomenator;
    int bottom = f1.denomenator*f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator -(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    int bottom = f1.denomenator*f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator *(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.numerator;
    int bottom = f1.denomenator*f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator /(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.denomenator;
    int bottom = f1.denomenator*f2.numerator;
    return Fraction(top, bottom);
}

Fraction operator +=(const Fraction f1, const Fraction f2){
    return f1 + f2;
}

Fraction operator -=(const Fraction f1, const Fraction f2){
    return f1 - f2;
}

Fraction operator *=(const Fraction f1, const Fraction f2){
    return f1*f2;
}

Fraction operator /=(const Fraction f1, const Fraction f2){
    return f1/f2;
}

Fraction operator +(const Fraction f1, const int f2){
    int top = f1.numerator + f2*f1.denomenator;
    int bottom = f1.denomenator;
    return Fraction(top, bottom);
}

Fraction operator +(const int f1, const Fraction f2){
    int top = f1*f2.denomenator + f2.numerator;
    int bottom = f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator -(const Fraction f1, const int f2){
    int top = f1.numerator - f2*f1.denomenator;
    int bottom = f1.denomenator;
    return Fraction(top, bottom);
}

Fraction operator -(const int f1, const Fraction f2){
    int top = f1*f2.denomenator - f2.numerator;
    int bottom = f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator *(const Fraction f1, const int f2){
    int top = f1.numerator*f2;
    int bottom = f1.denomenator;
    return Fraction(top, bottom);
}

Fraction operator *(const int f1, const Fraction f2){
    int top = f1*f2.numerator;
    int bottom = f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator /(const Fraction f1, const int f2){
    int top = f1.numerator;
    int bottom = f1.denomenator*f2;
    return Fraction(top, bottom);
}

Fraction operator /(const int f1, const Fraction f2){
    int top = f2.numerator;
    int bottom = f2.denomenator*f1;
    return Fraction(top, bottom);
}

bool operator ==(const Fraction f1, const Fraction f2){
    int result = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    if(result == 0){
        return true;
    }
    else{
        return false;
    }
}

bool operator >(const Fraction f1, const Fraction f2){
    int result = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    if(result > 0){
        return true;
    }
    else{
        return false;
    }
}

bool operator <(const Fraction f1, const Fraction f2){
    int result = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    if(result < 0){
        return true;
    }
    else{
        return false;
    }
}

bool operator >=(const Fraction f1, const Fraction f2){
    return !(f1 < f2);
}

bool operator <=(const Fraction f1, const Fraction f2){
    return !(f1 > f2);
}

bool operator !=(const Fraction f1, const Fraction f2){
    return !(f1 == f2);
}

Fraction fromstr(string s){
    int idx = s.find("/");
    if(idx != string::npos){
        string top = s.substr(0, idx);
        string bottom = s.substr(idx+1);
        int p = stoi(top);
        int q = stoi(bottom);
        return Fraction(p, q);
    }
    return Fraction(stoi(s));
}

int main(int argc, char const *argv[]){
    // Testing above class methods
    if(argc != 4){
        cout<<"Usage: "<< argv[0]<<"operand1 operator operand2";
        exit(1);
    }
    string s1(argv[1]);
    string op(argv[2]);
    string s2(argv[3]);

    Fraction o1 = fromstr(s1);
    Fraction o2 = fromstr(s2);

    if(op == "+"){
        cout<< (o1 + o2) << endl;
    }
    else if(op == "-"){
        cout<< (o1 - o2) << endl;
    }
    else if(op == "*"){
        cout<< (o1 * o2) << endl;
    }
    else if(op == "/"){
        cout<< (o1 / o2) << endl;
    }
    else if(op == "=="){
        cout<< (o1 == o2) << endl;
    }
    else if(op == "!="){
        cout<< (o1 != o2) << endl;
    }
    else if(op == ">"){
        cout<< (o1 > o2) << endl;
    }
    else if(op == "<"){
        cout<< (o1 < o2) << endl;
    }
    else if(op == ">="){
        cout<< (o1 >= o2) << endl;
    }
    else if(op == "<="){
        cout<< (o1 <= o2) << endl;
    }
    else{
        cout<<"Error: Invalid operand "<<op<<endl;
        exit(1);
    }
    return 0;
}

```
### Includes

In our sample, we include two standard library utilities:

```c++
#include <iostream>
#include <string>
```

Here, we can see that we include the standard I/O for printing messages onto the
screen and we include string for performing string operation

### simple gcd function

Here, We have defined gcd function which will give gcd of two numbers a and b using Euclid's Algorithm.
```c++
int gcd(int a, int b){
    if(a<0){
        a = -a;
    }
    while(a%b != 0){
        int i = a;
        int j = b;
        a = j;
        b = i%j;
    }
    return b;
}
```

### constructor of Fraction class

From there, we defined the `Fraction` class which we'll use to provide new data type for working with fractions:
```c++
class Fraction{
private:
    int numerator;
    int denomenator;

public:

    Fraction(int top=0, int bottom=1){
        if(bottom < 0){
            top = -top;
        }
        else if(bottom == 0){
            throw "Error: Denomenator can't be zero.";
        }
        int hcf = gcd(top, bottom);
        numerator = top/hcf;
        denomenator = bottom/hcf;
    }
```

### Implementation of unary operator minus 

Here, We implement method to handle unary minus operator which just negate numerator 
```c++
    Fraction operator -(){
        int top = -numerator;
        int bottom = denomenator;
        return Fraction(top, bottom);
    }
```

### Getters for numerator and denomenator

Below methods are just getters for the private attribute numerator and denomenator
```c++
    int getnumerator(){
        return numerator;
    }

    int getdenometor(){
        return denomenator;
    }
```

### Friend functions for Fraction class 

Here, We implement friend functions for Fraction class to perform Arithmatic and Relational operation and displaying
output of fraction using cout. This function just perform operator overloading.

```c++
    friend ostream &operator << (ostream &stream, const Fraction &frac);
    friend Fraction operator +(const Fraction f1, const Fraction f2);
    friend Fraction operator +(const Fraction f1, const int f2);
    friend Fraction operator +(const int f1, const Fraction f2);
    friend Fraction operator +=(const Fraction f1, const Fraction f2);
    friend Fraction operator -(const Fraction f1, const Fraction f2);
    friend Fraction operator -(const Fraction f1, const int f2);
    friend Fraction operator -(const int f1, const Fraction f2);
    friend Fraction operator -=(const Fraction f1, const Fraction f2);
    friend Fraction operator *(const Fraction f1, const Fraction f2);
    friend Fraction operator *(const Fraction f1, const int f2);
    friend Fraction operator *(const int f1, const Fraction f2);
    friend Fraction operator *=(const Fraction f1, const Fraction f2);
    friend Fraction operator /(const Fraction f1, const Fraction f2);
    friend Fraction operator /(const Fraction f1, const int f2);
    friend Fraction operator /(const int f1, const Fraction f2);
    friend Fraction operator /=(const Fraction f1, const Fraction f2);
    friend bool  operator ==(const Fraction f1, const Fraction f2);
    friend bool  operator <(const Fraction f1, const Fraction f2);
    friend bool  operator >(const Fraction f1, const Fraction f2);
    friend bool operator !=(const Fraction f1, const Fraction f2);
    friend bool operator <=(const Fraction f1, const Fraction f2);
    friend bool operator >=(const Fraction f1, const Fraction f2);
};
```

### stream operator

Here, We overloaded stream operator so that we can use cout directly on Fraction object.

```c++
ostream &operator <<(ostream &stream, const Fraction &frac){
    stream << frac.numerator << "/" << frac.denomenator;
    return stream;
}
```

### Addition 

Here, We have defined methods for addition operator for different cases.
EX: 1) Fraction(2, 3) + 6
    2) Fraction(2, 3) + Fraction(4, 5)
    3) 7 + Fraction(4, 5) 

```c++
Fraction operator +(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.denomenator + f2.numerator*f1.denomenator;
    int bottom = f1.denomenator*f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator +=(const Fraction f1, const Fraction f2){
    return f1 + f2;
}

Fraction operator +(const Fraction f1, const int f2){
    int top = f1.numerator + f2*f1.denomenator;
    int bottom = f1.denomenator;
    return Fraction(top, bottom);
}

Fraction operator +(const int f1, const Fraction f2){
    int top = f1*f2.denomenator + f2.numerator;
    int bottom = f2.denomenator;
    return Fraction(top, bottom);
}
```

### Substraction

Here, We have defined methods for substraction operator for different cases.
EX: 1) Fraction(2, 3) - 6
    2) Fraction(2, 3) - Fraction(4, 5)
    3) 7 - Fraction(4, 5) 

```c++
Fraction operator -(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    int bottom = f1.denomenator*f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator -=(const Fraction f1, const Fraction f2){
    return f1 - f2;
}

Fraction operator -(const Fraction f1, const int f2){
    int top = f1.numerator - f2*f1.denomenator;
    int bottom = f1.denomenator;
    return Fraction(top, bottom);
}

Fraction operator -(const int f1, const Fraction f2){
    int top = f1*f2.denomenator - f2.numerator;
    int bottom = f2.denomenator;
    return Fraction(top, bottom);
}
```

### Multiplication

Here, We have defined methods for multiplication operator for different cases.
EX: 1) Fraction(2, 3) * 6
    2) Fraction(2, 3) * Fraction(4, 5)
    3) 7 * Fraction(4, 5)

```c++
Fraction operator *(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.numerator;
    int bottom = f1.denomenator*f2.denomenator;
    return Fraction(top, bottom);
}

Fraction operator *=(const Fraction f1, const Fraction f2){
    return f1*f2;
}

Fraction operator *(const Fraction f1, const int f2){
    int top = f1.numerator*f2;
    int bottom = f1.denomenator;
    return Fraction(top, bottom);
}

Fraction operator *(const int f1, const Fraction f2){
    int top = f1*f2.numerator;
    int bottom = f2.denomenator;
    return Fraction(top, bottom);
}
```

### Division

Here, We have defined methods for division operator for different cases.
EX: 1) Fraction(2, 3) / 6
    2) Fraction(2, 3) / Fraction(4, 5)
    3) 7 / Fraction(4, 5) 

```c++
Fraction operator /(const Fraction f1, const Fraction f2){
    int top = f1.numerator*f2.denomenator;
    int bottom = f1.denomenator*f2.numerator;
    return Fraction(top, bottom);
}

Fraction operator /=(const Fraction f1, const Fraction f2){
    return f1/f2;
}

Fraction operator /(const Fraction f1, const int f2){
    int top = f1.numerator;
    int bottom = f1.denomenator*f2;
    return Fraction(top, bottom);
}

Fraction operator /(const int f1, const Fraction f2){
    int top = f2.numerator;
    int bottom = f2.denomenator*f1;
    return Fraction(top, bottom);
}
```

### Is equal to

Here, We implemented `==` operator to check if two Fractions are equal to each other

```c++
bool operator ==(const Fraction f1, const Fraction f2){
    int result = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    if(result == 0){
        return true;
    }
    else{
        return false;
    }
}
```

### Greater than

Here, We implemented `>` operator to check if first Fraction is greater than the second Fraction.

```c++
bool operator >(const Fraction f1, const Fraction f2){
    int result = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    if(result > 0){
        return true;
    }
    else{
        return false;
    }
}
```

### Less than

Here, We implemented `<` operator to check if first Fraction is less than the second Fraction.

```c++
bool operator <(const Fraction f1, const Fraction f2){
    int result = f1.numerator*f2.denomenator - f2.numerator*f1.denomenator;
    if(result < 0){
        return true;
    }
    else{
        return false;
    }
}
```

### Greater than or equal to

Here, We implemented `>=` operator to check if first Fraction is greater than or equal to the second Fraction.

```c++
bool operator >=(const Fraction f1, const Fraction f2){
    return !(f1 < f2);
}
```

### Less than

Here, We implemented `<=` operator to check if first Fraction is less than or equal to the second Fraction.

```c++
bool operator <=(const Fraction f1, const Fraction f2){
    return !(f1 > f2);
}
```

### Is not equal to

Here, We implemented `!=` operator to check if two Fractions aren't equal to each other

```c++
bool operator !=(const Fraction f1, const Fraction f2){
    return !(f1 == f2);
}
```

### From string to Fraction type

Here, We implemented function to perform conversion to Fraction from string object for that we are using find method to find `/`
in operand to differentiate numerator from denomenator after that we are using `stoi` to convert string to integer and finally we are returning newly created Fraction object. 
EX: "2/7" -> Fraction(2, 7)

```c++
Fraction fromstr(string s){
    int idx = s.find("/");
    if(idx != string::npos){
        string top = s.substr(0, idx);
        string bottom = s.substr(idx+1);
        int p = stoi(top);
        int q = stoi(bottom);
        return Fraction(p, q);
    }
    return Fraction(stoi(s));
}
```

### Main function

Here, we take varible arguments in main function from console to perform operation on fractions
if argc(argument count) is not 4 that's ./fraction(default: ./a.out) operand1 operator operand2 then it exit the program
otherwise, it converts those arguments to string object so that we can perform string to fraction coversion usinf fromstr function on it.

```c++
int main(int argc, char const *argv[]){
    // Testing above class methods
    if(argc != 4){
        cout<<"Usage: "<< argv[0]<<"operand1 operator operand2";
        exit(1);
    }
    string s1(argv[1]);
    string op(argv[2]);
    string s2(argv[3]);

    Fraction o1 = fromstr(s1);
    Fraction o2 = fromstr(s2);
```

### Execute Operations

From there, we check which operator is sent in the argument and perform operations according to that operator.
Ex: `if op == "+"` then print o1 + o2
    `if op == "=="` then print o1 == o2

```c++
    if(op == "+"){
        cout<< (o1 + o2) << endl;
    }
    else if(op == "-"){
        cout<< (o1 - o2) << endl;
    }
    else if(op == "*"){
        cout<< (o1 * o2) << endl;
    }
    else if(op == "/"){
        cout<< (o1 / o2) << endl;
    }
    else if(op == "=="){
        cout<< (o1 == o2) << endl;
    }
    else if(op == "!="){
        cout<< (o1 != o2) << endl;
    }
    else if(op == ">"){
        cout<< (o1 > o2) << endl;
    }
    else if(op == "<"){
        cout<< (o1 < o2) << endl;
    }
    else if(op == ">="){
        cout<< (o1 >= o2) << endl;
    }
    else if(op == "<="){
        cout<< (o1 <= o2) << endl;
    }
    else{
        cout<<"Error: Invalid operand "<<op<<endl;
        exit(1);
    }
    return 0;
}
```

## How to Run Solution

To run the fractions operation in cpp program, grab a copy of the fractions.cpp file
from GitHub. After that, get the latest version of g++ compiler. Now, all you have to
do is run the following from the command line:

```console
g++ fractions.cpp -o fractions
./fractions "1/4" "+" "5/8"
```

Alternatively, you can always copy the source code into an online c++
compiler. Just make sure you pass some input to your program before you run
it.

## Further Reading

- Fill in as needed

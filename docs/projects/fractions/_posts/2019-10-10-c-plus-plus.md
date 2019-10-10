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

int main(){
    // Testing above class methods
    Fraction f1(6, 2);
    Fraction f2(1, 4);
    cout<<-f1<<endl;
    f1 += f2;
    cout<<f1+f2<<endl;
    cout<<f1*f2<<endl;
    cout<<f1-f2<<endl;
    cout<<f1/f2<<endl;
    cout<<(f1 <= f2)<<endl;
    return 0;
}
```

Here, we defined the `Fraction` class which we'll use to provide new data type for working with fractions.
Inside this class, we begin by creating two private attributes numerator and denomenator.
Constructor of fractions takes two optional arguments top and bottom where top will be assigned to numerator and
bottom will be assigned to denometor.Here we checks if denometor is zeros then we throws an error and if denomenator is
negative then we negate top and bottom before assigning them.
We also have to implement getters for this Class and a method for unary operator `-`.
We also have to implement friend functions(one can use normal method) for binary operators like +, -, >=, == etc.

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

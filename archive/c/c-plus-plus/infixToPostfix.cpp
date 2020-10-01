#include <iostream>
#include <stack>

using namespace std;

bool isOperator(char c) {
    if(c == '+' || c == '-' || c == '*' || c == '/')
        return true;
    else
        return false;
}

int precedence(char c) {
    if( c == '+' || c == '-' )
        return 1;
    else if( c == '*' || c == '/' )
        return 2;
    else
        return 3;
}

void convert(string infix) {
    string postfix = "";
    stack<char> s;
    int length = infix.length();
    int i = 0;
    while(i < length) 
    {
        if( !isOperator(infix[i]) ) 
            postfix += infix[i++];
        else 
        {
            if(s.empty())
                s.push(infix[i++]);
            else if( precedence(infix[i]) > precedence(s.top()) )
                s.push(infix[i++]);
            else 
            {
                postfix += s.top();
                s.pop();
            }
        }
    }
    while(!s.empty())
    {
        postfix += s.top();
        s.pop();
    }
    cout << postfix;
}

int main() {
    string infix = "a+b*c-d";
    convert(infix);
}
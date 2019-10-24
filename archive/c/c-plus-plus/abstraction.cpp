#include<iostream.h>
#include<conio.h>

class sum
{
// hidden data from outside world
private: int a,b,c;

public:
void add()
{
clrscr();
cout<<"Enter any two numbers: ";
cin>>a>>b;
c=a+b;
cout<<"Sum: "<<c;
}
};
void main()
{
sum s;
s.add();
getch();
}
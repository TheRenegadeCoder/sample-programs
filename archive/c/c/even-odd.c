#include <stdio.h>
#include <conio.h>

void main() {
int a;
printf("Enter a Number: ");
scanf("%d",&a);
if(a%2==0)
    printf("%d is a Even.",a);
else
    printf("%d is Odd.",a);
getch();

}


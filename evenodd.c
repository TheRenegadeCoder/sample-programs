#include<stdio.h>
#include<ctype.h>

int main()
{
    int a;
    printf("Enter a number \n");
    scanf("%d",&a);

    if(scanf("%d", &a))
    {

    if(isalpha(a))
        printf("Not a number \n");
    else
    {
        if(a%2==0)
           printf("Even number \n");
        else
           printf("Odd number \n");
    
    }
    }
    else
    printf("Enter an input \n");
    
    
return 0;
}
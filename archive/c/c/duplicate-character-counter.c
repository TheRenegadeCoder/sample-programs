#include <stdio.h>
#include <string.h>
#include<stdlib.h>

// Function to handle errors
int handle_error()
{
    printf("Usage: please provide a string\n");
    exit(0);
}

int main(int argc, char *argv[])
{
    /*
        Condition to check for No String as Input
    */
    if (argc !=2 )
    {
        handle_error();
    }
    /*
        Condition to check for No String as Input
    */
    if(strlen(argv[1]) == 0){
        handle_error();
    }
    int counter[256]={0};
    int len = strlen(argv[1]);
    for(int i=0;i<len;i++){
        counter[argv[1][i]-1]++;
    }
    int flag = 1;
    for(int i=0;i<len;i++){
        char c = argv[1][i];
        if(counter[c-1]>1){
            flag = 0;
            printf("%c: %d\n",c,counter[c-1]);
            counter[c-1]=0;
        }
    }
    if(flag == 1){
        printf("No duplicate characters\n");
    }
    return 0;
}
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void error(){
    printf("Usage: please provide a string\n");
    exit(0);
}
int main(int argc, char *argv[])
{
    if(argc<2){
        error();
    }
    if(strlen(argv[1])<=0){
        error();
    }
    int max = -1;
    char* word = strtok(argv[1], " ,\n\t");
    while (word != NULL) {
        int len = strlen(word);
        if(len>max){
            max = len;
        }
        word = strtok(NULL, " ,\n\t");
    }

    printf("%d",max);
      
    
    return 0;
}

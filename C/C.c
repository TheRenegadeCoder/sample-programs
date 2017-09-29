#include<stdio.h>
int main()
{
 int i, j, spaceNumber, starNumber, size;
    size = 11;
    spaceNumber = size / 2 ;
    starNumber = 1;
    for(i=0; i<size; i++){
        for(j=0; j<spaceNumber; j++)
            printf(" ");
        for(j=0; j<starNumber; j++)
            printf("*");
        if(i < size / 2){
            spaceNumber--;
            starNumber+=2;
        }
        else{
            spaceNumber++;
            starNumber-=2;
            }
        printf("\n");
    }
    
    return 0;
}
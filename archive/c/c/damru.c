/*

	DAMRU

*/

#include<stdio.h>

int main(){
	
	int i,j;
	
    for(i=1;i<=11;i++){

		for(j=1;j<=11;j++){
			printf(" ");
            
            if(j==1 || i==j ||  j==11 || (j==6 && i>5 )|| (i+j)==12){
				printf("*");
            } else { 
				printf(" ");
				}
        } //inner for

    printf("\n");
    
    } //outer for
	return 0;

} //main

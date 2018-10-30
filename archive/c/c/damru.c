/*
  DAMARU - A small two-headed, traditional drum
          used to produce spiritual sounds in Hinduism and Tibetan Buddhism.

  The programme (Damru.c) is a way of printing the same shape on the console using star(*).
  Read more - https://en.wikipedia.org/wiki/Damaru
*/

#include<stdio.h>

int main(){
  int i,j;

  for(i=1; i<=11; i++){

    for(j=1; j<=11; j++){
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

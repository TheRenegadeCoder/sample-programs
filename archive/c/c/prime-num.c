#include <stdio.h>
#include <stdlib.h>

int main() {

  int a,i,p=0;
  printf("Enter a Number: ");
  scanf("%d",&a);

  for(i=2; i<=a/2; i++){
      if(a%i==0)
          {
              p=1;
              break;
            }
        }

  if(p==0)
      printf("%d is a Prime Number.",a);
  else
      printf("%d is not a Prime Number.",a);

  return 0;

}

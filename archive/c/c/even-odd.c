#include <stdio.h>
#include <stdlib.h>

int main() {
  int a;
  printf("Enter a Number: ");
  scanf("%d", &a);

  if(a%2==0)
      printf("%d is a Even.", a);
  else
      printf("%d is Odd.", a);

  return 0;
}

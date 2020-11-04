/*
( Removing extra white spaces from a given string )

This Program is to remove
extra white spaces
from a given string
in c programming language

::  © Created By GitHub@barhouum7
::  v1.1
*/

#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>

/* I Create this function to avoid the unsafe input
    ( both of scanf() and gets() are not safe input method. ) */
int input(char str[])
{
  int ch, i = 0, test = 0;

  printf("\n\n\t\t Enter your string here : ");
  while (((ch = getchar()) != '\n'))
  {
    if ((ch != '\n'))
    {
      if ((ch != ' '))
        str[i++] = ch;
      else
      {
        test++;
      }
    }
  }

  str[i] = '\0';
  if (i == 0)
    printf("\n\n\t\t\t Wrong input! , please try again.");
  return i;
}

int main(void)
{
  char str[100];
  printf("\n\n\t\t\t Your input string is %s   |   Length is %d .", str, input(str));

  /* ----------------------------------------------------------------------------------------------------------------------- */
  printf("\n\n\n\n\n\n\n\n               ----------------------------------------------------------\n");
  printf("\n              |    Mind Hackers ! - Removing extra whiteSpaces  .   ^,^    |");
  printf("\n\n               ----------------------------------------------------------\n\n");
  getch();
  system("PAUSE");
  return 0;
}

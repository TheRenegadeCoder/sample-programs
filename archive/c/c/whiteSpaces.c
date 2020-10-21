/*
( Removing extra white spaces from a given string )

This Program is to remove
extra white spaces
from a given string
in c programming language

::  © Created By GitHub@barhouum7
*/

#include <stdio.h>
#include <stdlib.h>
// #include<conio.h>
#include <string.h>
//#include<math.h>

/* I Create this function to avoid the unsafe input
    ( both of scanf() and gets() are not safe input method. ) */
int input(char str[])
{
  int ch, i = 0, test = 0;
  // char userOption;
  // do{

  //Reading the string from user ...
  //do{
  // do{
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
        // printf("\n\n\t\t\tWrong input ! , please try again.");
      }
    }
  }
  //   str = "";
  // }while(str[i] == ' ');

  // if((str[i] == ' ' || str[i+1] == ' ')){
  //   str[i] = '\0';
  //   break;
  // }else{
  //   str = "";
  //   printf("\n\n\t\t\tWrong input ! , please try again.");
  // }
  //}while(!(str[i] == ' ' || str[i+1] == ' '));

  //   printf("\n\n\t\tDo you want to continue the input ? y/n");
  //   userOption = getche();
  // }while(userOption == 'y');

  str[i] = '\0';
  return i;
}

int main(void)
{
  //WELCOME Part ...
  printf("\n\n            <<<<<<<<     Hello World ! :)    >>>>>>>>\n\n\n");
  //Declaration Part...

  // char chaine[100], chaineTemp[100];
  // int i = 0, j = 0;
  // //Reading the string from user ...
  //    printf("\n\n\t\tEnter your string : ");
  //    gets(chaine);
  // //Finding the first two white spaces successive ..
  //    while (chaine[i] != '\0')
  //    {
  //       if (!(chaine[i] == ' ' && chaine[i+1] == ' ')) {
  //         chaineTemp[j] = chaine[i];
  //         j++;
  //       }
  //       i++;
  //    }
  //    //Determine the end of the string ...
  //    chaineTemp[j] = '\0';
  //
  //    printf("\n\n\t\tThe string after removing whiteSpaces :\n\n\t\t\t|%s|\n", chaineTemp);

  char str[100];
  printf("\n\n\t\t\t Your input string is %s , and her length is %d .", str, input(str));

  /* ----------------------------------------------------------------------------------------------------------------------- */
  printf("\n\n\n\n\n              |    Mind Hackers ! - Removing extra whiteSpaces  .   ^,^    |");
  printf("\n\n                         ----------------------------------------\n\n\n\n");
  system("PAUSE");
  return 0;
}

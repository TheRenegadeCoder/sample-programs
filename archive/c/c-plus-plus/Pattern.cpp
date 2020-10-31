#include<iostream>
#include<stdlib.h>
using namespace std;
int main()
{
    int choice,rows,i,j,space;char ans;
    do{
            cout<<"Patterns!\n\n Select the pattern you want to print-\n1.Full Star Pyramid\n2.Inverted Full Star Pyramid\n3.Half Star Pyramid";
            cout<<"\n4.InvertedHalf Star Pyramid\n5.Hollow Star Pyramid\n6.Inverted Hollow Star Pyramid\n\n";
            cin>>choice;
            cout<<"Enter the number of rows:";
            cin>>rows;
            cout<<"\n\n";
            switch(choice)
            {
                case 1:
                    for(i = 1; i <= rows; i++)
                    {
                        for(space = i; space < rows; space++)
                        {
                            cout << " ";
                        }
                        for(j = 1; j <= (2 * i - 1); j++)
                        {
                            cout << "*";
                        }

                        cout << "\n";
                    }
                    break;

                case 2:
                    for(i = rows; i >= 1; i--)
                    {
                        for(space = i; space < rows; space++)
                            cout << " ";
                        for(j = 1; j <= (2 * i - 1); j++)
                            cout << "* ";

                        cout << "\n";
                    }
                    break;

                case 3:
                    for(i = 1; i <= rows; i++)
                    {
                        for(j = 1; j <= i; j++)
                            cout << "* ";
                        cout << "\n";
                    }
                    break;

                case 4:
                    for(i = rows; i >= 1; i--)
                    {
                        for(j = 1; j <= i; j++)
                            cout << "* ";
                        cout << "\n";
                    }
                    break;

                case 5:
                    for(i = 1; i <= rows; i++)
                    {
                        for (space = i; space < rows; space++)
                            cout << " ";
                        for(j = 1; j <= (2 * rows - 1); j++)
                        {
                            if(i == rows || j == 1 || j == 2*i - 1)
                                cout << "*";
                            else
                                cout << " ";
                        }
                        cout << "\n";
                    }
                    break;

                case 6:
                    for(i = rows; i >= 1; i--)
                    {
                        for (space = i; space < rows; space++)
                            cout << " ";
                        for(j = 1; j <= 2 * i - 1; j++)
                        {
                            if(i == rows || j == 1 || j == 2*i - 1)
                                cout << "*";
                            else
                                cout << " ";
                        }
                        cout << "\n";
                    }
                    break;

                default:
                    cout<<"Please select a number from the given options!";

            }
            cout<<"Do you want to continue(Y/N)?";
            cin>>ans;
            system("CLS");

    }while(ans=='Y'||ans=='y');
    return 0;
}

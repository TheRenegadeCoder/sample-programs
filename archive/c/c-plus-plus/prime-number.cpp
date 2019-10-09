#include <iostream>
#include <limits>
using namespace std;
int main()
{
  int n, i;
  bool isPrime = true;
  cout << "Enter a positive integer: ";
  cin >> n;
  while(1)
    {
        if(cin.fail())
           {
               cin.clear();
               cin.ignore(numeric_limits<streamsize>::max(), '\n');
               cout<<"please input a non-negative integer"<<endl;
               cin>>n;
           }
        if(!cin.fail())
            break;
     }

  for(i = 2; i <= n / 2; ++i)
  {
      if(n % i == 0)
      {
          isPrime = false;
          break;
      }
  }
  if (isPrime)
      cout << "Prime";
  else
      cout << "Composite";
  return 0;
}

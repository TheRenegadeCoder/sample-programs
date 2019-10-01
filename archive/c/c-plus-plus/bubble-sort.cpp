  
#include <iostream>
#include <vector>
using namespace std;

int main(int argc, char *argv[])
{
  //Taking Inputs---
  string n = argv[1];
  int i=0;
  vector<int> arr;

  if(n[i]-'0'>=0 && n[i]-'0'<=9)
    arr.push_back(n[i]-'0');
  else 
    return 0;
  //---

  //Checking all conditions----
  i++;
  if(i<n.size())
  {
    while(i<n.size())
    {
      if(n[i]==',' && n[i+1]==' ')i+=2;
      else return 0;//Does not have proper arrangement of numbers with ", "
      int check = n[i]-'0';
      if(check>=0 && check<=9)arr.push_back(check);
      else return 0;//Not an integer
      i++;
    }
  }
  else
    return 0;//Not a list
  //----

  //Bubble Sort-----
  for (int i = 0; i < arr.size()-1; ++i)
  {
    for(int j=0;j<arr.size()-1-i;j++)
    {
      if(arr[j]>arr[j+1])
      {
        //Swap arr[j] and arr[j+1] using Xor
        arr[j] = arr[j]^arr[j+1];
        arr[j+1] = arr[j]^arr[j+1];
        arr[j] = arr[j]^arr[j+1];
      }
    }
  }
  //-----

  //Printing Values------
  cout<<arr[0];
  for(int i=1;i<arr.size();i++)
    cout<<", "<<arr[i];
  //------
  return 0;
}

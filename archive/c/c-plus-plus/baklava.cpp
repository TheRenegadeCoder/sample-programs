#include <iostream>

using namespace std;

int main(int argc, char *argv[])
{
  int i,j,k,n;
  n = 21;
  for(i=1; i<=(n+1)/2; )
    {
      for(k=1; (n+1)/2-i>=k; k++)
        cout<<" ";
      for(j=1; j<2*i; j++)
        cout<<"*";
      cout<<"\n";
      i++;
    }
  if(2*i-1>=n)
    {
      for(i=(n+1)/2-1; i>=1; i--)
        {
          for(k=1; (n+1)/2-i>=k; k++)
            cout<<" ";
          for(j=1; j<2*i; j++)
            cout<<"*";
          cout<<"\n";
        }
    }
  return(0);
}

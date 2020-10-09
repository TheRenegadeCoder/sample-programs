#include <bits/stdc++.h>
#include <limits.h>
#define NO_OF_CHARS 256
using namespace std;
//Here position is the first occurence of that character
struct countposition
{
  int count;
  int position;
};
void firstNonRepeatingChar(char *s)
{
  int res = INT_MAX;
  countposition* count = new countposition[NO_OF_CHARS];
  for(int i=0; i<strlen(s); i++)
  {
    (count[s[i]].count)++; //increment the count of each character by using ASCII of character as key  
    //storing the position of the first occurencce
    if (count[s[i]].count == 1)
    {
      count[s[i]].position = i;
    }
  }
  //In count array, if count is 1 and position is least then update  
  for(int i=0; i<NO_OF_CHARS; i++)
  {
    if(count[i].count == 1 && res > count[i].position) //if count is 1, then print and break
    {
      res = count[i].position;
    }
  }
  cout<<s[res]<<" is the first non-repeating character "<<endl;
}
int main()
{
  char s[]  = "tutorial cup";
  cout<<"Input string is "<<s<<endl;
  firstNonRepeatingChar(s);
}
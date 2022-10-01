#include<bits/stdc++.h>
using namespace std;

int main(){
    string inputStr;
    cin>>inputStr;
    unordered_map<char,int> m1;

    for(auto x : inputStr)
    {
         if(m1.find(x) == m1.end())
           {
               m1.insert({x,1});
           }
           else
           {
               m1[x]++;
           }
    }
    int flag = 1;
    for(int i =0; i<inputStr.length(); i++)
       {
           if(m1[inputStr[i]]>1)
            {
                flag = 0;
                cout<<inputStr[i]<<":"<<m1[inputStr[i]]<<"\n";
                m1[inputStr[i]]=0;
            }
            
       }
       if(flag==1)
         cout<<"No duplicate characters\n";
	return 0;
}
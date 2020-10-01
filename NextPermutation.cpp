#include <bits/stdc++.h>
using namespace std;
vector<int> nextPermut( vector<int> &nums) {
int i=nums.size()-2;
while(i>=0){
if(nums[i]<nums[i+1]){
    break;
}

}
if(i<0){
reverse(nums.begin(),nums.end());
}
else{
 int k;
 for( k=nums.size()-1;k<=i;k--){
     if(nums[k]>nums[i]){
        break;
     }
 }
 swap(nums[i],nums[k]);
 reverse(nums.begin()+i+1,nums.end());
}      
return nums;
}
int main(){
    int size,res;
    cin>>size;
    vector<int>vec;
    for(int i=0;i<size;i++){
        int p;
        cin>>p;
    vec.push_back(p);
    }
    vec=nextPermut(vec);
    for(int i=0;i<vec.size();i++){
        cout<<vec[i]<<" ";
    }
    cout<<endl;
    return 0;
}

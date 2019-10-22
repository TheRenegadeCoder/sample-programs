#include  <stdio.h>
#include <stdlib.h>
#include <string.h>

int val[150];

int main(int argc,char **argv)
{
    if(argv[1]==NULL){
        printf("Usage: please provide a string of roman numerals");
        return 0;
    }
    if(strlen(argv[1])==0){
        printf("0");
        return 0;
    }
    
    int len=strlen(argv[1]);
    val['I']=1;
    val['V']=5;
    val['X']=10;
    val['L']=50;
    val['C']=100;
    val['D']=500;
    val['M']=1000;
    long long ans=0;
    
    for(int i=1;i<len;++i){
        if(!val[argv[1][i]]){
            printf("Error: invalid string of roman numerals");
            return 0;
        }
        if(val[argv[1][i]]>val[argv[1][i-1]])ans-=2*val[argv[1][i-1]];
        ans+=val[argv[1][i]];
    }
    if(!val[argv[1][0]]){
        printf("Error: invalid string of roman numerals");
        return 0;
    }
    printf("%lld",ans+val[argv[1][0]]);
}
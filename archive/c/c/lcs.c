#include  <stdio.h>
#include <stdlib.h>
#include <string.h>
long long arr[100000],arr1[100000];
int lc[1000][1000];
long long ans[100000];
int indic;

long long get_val(int tmp[],int len){
    long long value=0,mult=1;
    for(int i=len-1;i>-1;--i){
        if(tmp[i]==' '-'0'){
            printf("Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"");
            exit(0);
        }
        value+=tmp[i]*mult;
        mult*=10;
    }
    return value;
}

int max(int a,int b){
    return a>b?a:b;
}

int lcs(int l,int r){
    if(l<0||r<0)return 0;
    if(lc[l][r]!=-1)return lc[l][r];
    if(arr[l]==arr1[r])lc[l][r]=lcs(l-1,r-1)+1;
    lc[l][r]=max(lc[l][r],max(lcs(l,r-1),lcs(l-1,r)));
    return lc[l][r];
}

void find(int l,int r){
    if(l<0||r<0)return ;
    if(arr[l]==arr1[r]){
        ans[indic++]=arr[l];
        find(l-1,r-1);
    }
    else if(lc[l-1][r]==lc[l][r])find(l-1,r);
    else find(l,r-1);
}

int main(int argc,char **argv)
{
    if(argv[1]==NULL||strlen(argv[1])==0||argv[2]==NULL||strlen(argv[2])==0){
        printf("Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"");
        return 0;
    }

    int len = strlen(argv[1]);
    int tmp[20];
    int ind=0;
    int pos=0;
    
    for(int i=0;i<len;++i){
        if(argv[1][i]==','){
            long long val = get_val(tmp,ind);
            ind=0;
            i++;
            arr[pos++]=val;
            continue;
        }
        tmp[ind++]=argv[1][i]-'0';
    }
    arr[pos++]=get_val(tmp,ind);
    int len1=pos;
    ind=0,pos=0;
    len=strlen(argv[2]);
    for(int i=0;i<len;++i){
        if(argv[2][i]==','){
            long long val = get_val(tmp,ind);
            ind=0;
            i++;
            arr1[pos++]=val;
            continue;
        }
        tmp[ind++]=argv[2][i]-'0';
    }
    arr1[pos++]=get_val(tmp,ind);
    memset(lc,-1,sizeof(lc));
    lcs(len1-1,pos-1);
    find(len1-1,pos-1);
    for(int i=indic-1;i>-1;--i){
        printf("%lld",ans[i]);
        if(i!=0)printf(", ");
    }
}
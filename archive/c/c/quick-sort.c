#include  <stdio.h>
#include <string.h>
#include <stdlib.h>

long long get_val(int tmp[],int len){
    long long value=0,mult=1;
    for(int i=len-1;i>-1;--i){
        if(tmp[i]==' '-'0'){
            printf("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n");
            exit(0);
        }
        value+=tmp[i]*mult;
        mult*=10;
    }
    return value;
}


void swap(long long* a, long long* b) 
{ 
    int t = *a; 
    *a = *b; 
    *b = t; 
} 

int partition (long long arr[], int low, int high) 
{ 
    long long pivot = arr[high];    
    int i = low-1;

    for (int j = low; j <= high- 1; j++) 
    { 
        if (arr[j] < pivot) 
        { 
            i++;
            swap(&arr[i], &arr[j]); 
        } 
    } 
    swap(&arr[i + 1], &arr[high]); 
    return i+1; 
} 

void quickSort(long long arr[], int low, int high) 
{ 
    if (low < high) 
    { 
        int pi = partition(arr, low, high); 
        quickSort(arr, low, pi - 1); 
        quickSort(arr, pi + 1, high); 
    } 
} 

void print(long long arr[], int size) 
{ 
    for (int i=0; i < size; i++) 
    {
        printf("%lld", arr[i]); 
        if(i!=size-1)printf(", ");
    }
        
    printf("\n"); 
} 

int main(int argc,char **argv)
{
    while(argv[1]==NULL||strlen(argv[1])==0){
        printf("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n");
        return 0;
    }
    int len = strlen(argv[1]);
    int tmp[10];
    int ind=0;
    int pos=0;
    long long arr[100000];

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
    if(pos==1){
        printf("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n");
        return 0;
    }


    quickSort(arr,0,pos-1);
    print(arr,pos);
} 
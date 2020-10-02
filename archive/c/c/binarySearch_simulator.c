#include<stdio.h>
#include<stdlib.h>

typedef long long int ll;
typedef unsigned long long int llu;

ll* newArr(llu);
void fillArr(ll*, llu, char*);
void fetchSize(llu*, char*);
void printArr(ll*, llu);
ll fixPivot(ll* arr, ll l, ll r);
void swap(ll* x, ll* y);
void quicksort(ll* arr, ll l, ll r);

int binarySearch(ll* arr, ll l, ll r, ll reqT){
	if(l>r)
		return -1;

	ll m= (ll)((l +(r-l)/2.0));
	if(*(arr+m)== reqT)
		return m;
	else if(reqT< *(arr+m))
		r= m-1;
	else
		l= m+1;
	return binarySearch(arr, l, r, reqT);
}

ll* newArr(llu n){
	return (llu*)malloc(n*sizeof(llu));
}

void fillArr(ll* arr, llu n, char* msg){
	printf("%s\n", msg);
	for(llu i=0; i<n; i++)
		scanf("%lld", (arr+ i));
}

void fetchSize(llu* size, char* msg){
	printf("%s ", msg);
	llu n; scanf("%lld", size);
}

void printArr(ll* arr, llu n){
	for(llu i=0; i< n; i++)
		printf("%lld ", *(arr+ i));
	printf("\n");
}

void swap(ll* x, ll* y){
	ll temp = *x;
	*x = *y;
	*y = temp;
}

ll fixPivot(ll* arr, ll l, ll r){
	ll smollInd= l-1, pivot= *(arr+r);
	while(l<r){
		if(*(arr+l)<= pivot){
			smollInd++;
			swap(arr+l, arr+smollInd);
		}
		l++;
	}
		swap(arr+smollInd+1, arr+r);
		return (smollInd+1);     
}

void quicksort(ll* arr, ll l, ll r){
	if(l< r){
		ll pivotAt;
		pivotAt = fixPivot(arr, l, r);
		quicksort(arr, l, pivotAt-1);
		quicksort(arr, pivotAt, r);
	}
} 

void randomFill(ll* arr, llu size, ll minVal, ll maxVal){
	for(llu i=0; i<size; i++){
		*(arr + i) = rand()%(maxVal+1) + minVal;
	}
}

void randomNum(llu* target, ll minVal,ll maxVal){
	*target =  rand()%(maxVal+1) + minVal;
}

void config_simulator(ll* folds, ll* minSize, ll* maxSize, ll* maxVal, ll* minVal){
	printf("\n\n~~~~~~~Binary-Search SIMULATOR CONFIGURATOR~~~~~~~\n\nIterations-> ");
	scanf("%lld", folds);
	printf("Min array-size-> ");
	scanf("%lld", minSize);
	printf("Max array-size-> ");
	scanf("%lld", maxSize);
	printf("Max array-value-> ");
	scanf("%lld", maxVal);
	printf("Min array-value-> ");
	scanf("%lld", minVal);
	printf("\nStarting Stimulator..\n\n");
}

void simulator(ll folds, ll minSize, ll maxSize, ll maxVal, ll minVal){
	//char* Pmsg = "Element found.", Nmsg = "Not found.";
	while(folds--){
		llu size; randomNum(&size, minSize, maxSize);
		ll* arr = newArr(size);
		randomFill(arr, size, minVal, maxVal);
		printf("Original Array~~~~~~~~\n");
		printArr(arr, size);
		printf("Sorting the same~~~~~~\n");	
		quicksort(arr, 0, (ll)size-1);
		printArr(arr, size);

		llu key; randomNum(&key, minVal, maxVal+10);
		printf("Random element picked-> %llu\t", key);
		ll result = binarySearch(arr, 0, (ll)size-1, (ll)key);
		printf("binarySearch result: %lld", result);

		key = *(arr+ size-1);
		printf("\nPicking Last element -> %lld\t", key);
		result = binarySearch(arr, 0, (ll)size-1, (ll)key);
		printf("binarySearch result: %lld", result);
		t = clock() - t;
		double timeTaken = ((double)t)/
		printf("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
		free(arr);
	}
}

int main(void){
	// llu size; fetchSize(&size, "Number of elements? ");
	// ll* arr = newArr(size); fillArr(arr, size, "Drop all elements in space separated format, please:)");
	// quicksort(arr, 0, (ll)size-1, 0);
	// printArr(arr, size); 
	ll folds, minSize, maxSize, maxVal, minVal;
	config_simulator(&folds, &minSize, &maxSize, &maxVal, &minVal);
	simulator(folds, minSize, maxSize, maxVal, minVal);
	return 0;
}
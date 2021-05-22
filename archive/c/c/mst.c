#include  <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Edge{ 
	int src, dest;
    long long weight; 
}; 

long long get_val(int tmp[],int len){
    long long value=0,mult=1;
    for(int i=len-1;i>-1;--i){
        if(tmp[i]==' '-'0'){
            printf("Usage: please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”\n");
            exit(0);
        }
        value+=tmp[i]*mult;
        mult*=10;
    }
    return value;
}

struct Graph{ 
	int V, E; 
	struct Edge* edge; 
}; 

struct Graph* createGraph(int V, int E){ 
	struct Graph* graph = malloc(sizeof(struct Graph)); 
	graph->V = V; 
	graph->E = E; 
	graph->edge = malloc(sizeof(struct Edge)*E); 
	return graph; 
} 

struct subset{ 
	int parent; 
	int rank; 
}; 

int find(struct subset subsets[], int i){ 
	if (subsets[i].parent != i) 
		subsets[i].parent = find(subsets, subsets[i].parent); 
	return subsets[i].parent; 
} 

void Union(struct subset subsets[], int x, int y){ 
	int xroot = find(subsets, x); 
	int yroot = find(subsets, y); 
	if (subsets[xroot].rank < subsets[yroot].rank) subsets[xroot].parent = yroot; 
	else if (subsets[xroot].rank > subsets[yroot].rank) subsets[yroot].parent = xroot; 
	else{ 
		subsets[yroot].parent = xroot; 
		subsets[xroot].rank++; 
	} 
} 

int myComp(const void* a, const void* b){ 
	struct Edge* a1 = (struct Edge*)a; 
	struct Edge* b1 = (struct Edge*)b; 
	return a1->weight > b1->weight; 
} 

void KruskalMST(struct Graph* graph){ 
	int V = graph->V; 
    long long res=0;
	int e = 0; 
	int i = 0;  
	qsort(graph->edge, graph->E, sizeof(graph->edge[0]), myComp); 
    
	struct subset *subsets =(struct subset*)malloc( V * sizeof(struct subset) ); 
	for(int v = 0; v < V; ++v){ 
		subsets[v].parent = v; 
		subsets[v].rank = 0; 
	} 
	while (e < V - 1 && i < graph->E){ 
		struct Edge next_edge = graph->edge[i++]; 
		int x = find(subsets, next_edge.src); 
		int y = find(subsets, next_edge.dest); 
		if (x != y){ 
			res = res + next_edge.weight; 
			Union(subsets, x, y); 
		} 
	} 
	printf("%lld",res); 
	return; 
} 

int floorSqrt(int x){ 
    if (x == 0 || x == 1)return x; 
    int i = 1,result = 1; 
    while (result <= x){ 
      i++; 
      result = i * i; 
    } 
    return i - 1; 
}

int main(int argc,char **argv)
{
    if(argv[1]==NULL||strlen(argv[1])==0){
        printf("“Usage: please provide a comma-separated list of integers”");
        return 0;
    }
    
    int len = strlen(argv[1]);
    int tmp[20];
    int ind=0;
    int pos=0;
    long long arr[100000];
    int E=0;
    for(int i=0;i<len;++i){
        if(argv[1][i]==','){
            long long val = get_val(tmp,ind);
            ind=0;
            i++;
            arr[pos++]=val;
            if(val!=0)E++;
            continue;
        }
        tmp[ind++]=argv[1][i]-'0';
    }
    arr[pos++]=get_val(tmp,ind);
    int sq=floorSqrt(pos);
    if(pos!=sq*sq){
        printf("“Usage: please provide a comma-separated list of integers”");
        return 0;
    }
    int V=sq;
    
    struct Graph* graph = createGraph(V, E);
    int index=0;
    for(int i=0;i<pos;++i){
        if(arr[i]==0)continue;
        graph->edge[index].src = i/V; 
        graph->edge[index].dest = i-(i/V)*V; 
        graph->edge[index++].weight = arr[i];
    }
    KruskalMST(graph);
}
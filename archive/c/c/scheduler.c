#include<stdio.h>
#include<stdlib.h>
#include"arr_handle.h"
#include"divyu.h"
#include<limits.h>

typedef long long int ll;

void sjf_nonPreEmptive(ll* bursTime, ll* arrvlTime, ll* compTime, llu size){
	ll* arrvlOrd= createAug(arrvlTime, size);
	ll tasksLeft= (ll)size, runtime= arrvlTime[*(arrvlOrd)];
	while(tasksLeft){
		ll task=0, minBT= LONG_MAX, prgID= -1, ind= -1;
		while(task< tasksLeft && runtime>= arrvlTime[*(arrvlOrd+ task)]){
			ll bt= *(bursTime+ *(arrvlOrd+ task));
			if(bt< minBT){
				minBT= bt;
				prgID= *(arrvlOrd+ task);
				ind  = task; 
			}
			task++;
		}
		if(minBT!=LONG_MAX){
			runtime+= minBT;
			*(compTime+ prgID)= runtime;
			_remove(arrvlOrd, ind, tasksLeft);
			tasksLeft--;
		}
		else
			runtime= arrvlTime[*arrvlOrd];
	}
	printArr(compTime, size);
}

void sjf_preEmptive(ll* bursTime, ll* arrvlTime, ll* compTime, llu size){
	ll* arrvlOrd= createAug(arrvlTime, size);
	ll tasksLeft= (ll)size, runtime= arrvlTime[*(arrvlOrd)];
	while(tasksLeft){
		ll task=0, minBT= LONG_MAX, prgID= -1, ind= -1;
		while(task< tasksLeft && runtime>= arrvlTime[*(arrvlOrd+ task)]){
			ll bt= *(bursTime+ *(arrvlOrd+ task));
			if(bt< minBT){
				minBT= bt;
				prgID= *(arrvlOrd+ task);
				ind  = task; 
			}
			task++;
		}
		if(minBT!=LONG_MAX){
			*(bursTime+ prgID)-=1;
			runtime+= 1;
			if(*(bursTime+ prgID)== 0){
				*(compTime+ prgID)= runtime;
				_remove(arrvlOrd, ind, tasksLeft);
				tasksLeft--;
			}
		}
		else
			runtime= arrvlTime[*arrvlOrd];
	}
	printArr(compTime, size);
}

void sjf_preEmptive_IO(ll* bursTime, ll* arrvlTime, ll* compTime, llu size){
	ll* arrvlOrd= createAug(arrvlTime, size);
	ll* flag= newArr(size); fillVal(flag, size, 0);
	ll* IO= newArr(size); fillArr(IO, size, "IO times? ");
	ll* newBurst= newArr(size); fillArr(newBurst, size, "BT-2? ");	
	ll tasksLeft= (ll)size, runtime= arrvlTime[*(arrvlOrd)];
	while(tasksLeft){
		ll task=0, minBT= LONG_MAX, prgID= -1, ind= -1;
		while(task< tasksLeft && runtime>= arrvlTime[*(arrvlOrd+ task)]){
			ll bt= *(bursTime+ *(arrvlOrd+ task));
			if(bt< minBT){
				minBT= bt;
				prgID= *(arrvlOrd+ task);
				ind  = task; 
			}
			task++;
		}
		if(minBT!=LONG_MAX){
			*(bursTime+ prgID)-=1;
			runtime+= 1;
			if(*(bursTime+ prgID)== 0){
				if(*(flag+ prgID)){
					*(compTime+ prgID)= runtime;
					_remove(arrvlOrd, ind, tasksLeft);
					tasksLeft--;
				}
				else{
					*(arrvlTime+ prgID)= (runtime+ *(IO+ prgID));
					*(bursTime+ prgID) = *(newBurst+ prgID);
				}
			}
			else;
		}
		else
			runtime= arrvlTime[*arrvlOrd];
	}
	printArr(compTime, size);
}

int main(){
	llu size; fetchSize(&size, "Number of processes? ");
	ll* bursTime= newArr(size); ll* arrvlTime= newArr(size); ll* compTime= newArr(size);
	fillArr(bursTime, size, "Drop burst time for all processes:)");
	fillArr(arrvlTime, size, "same for arrival times..");
	//sjf_preEmptive_IO(bursTime, arrvlTime, compTime, size);
	free(bursTime); free(arrvlTime);
}
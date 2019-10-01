#!/bin/bash

array=(3 35 2 5 4 7 3 0 10 -2 12 3)

function bubble-sort {
	new_array=(${array[@]::${#array[@]}-1}) #all elements except the last one
	for i in "${!array[@]}"; do
		switch=false;
		for j in "${!new_array[@]}" ; do
			if [ "${array[j]}" -gt "${array[j+1]}" ]; then
				aux=${array[j]}
				array[j]=${array[j+1]}
				array[j+1]=$aux
				switch=true;
			fi;
		done;
		if [ $switch = false ]; then 
			break; 
		fi;
	done;
}

echo ${array[@]}

bubble-sort

echo ${array[@]}

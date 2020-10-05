#!/bin/bash
# By Jan-Hendrik Ewers (iwishiwasaneagle)
# 04/10/2020

function exit_with_err(){
    USAGE='Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    echo $USAGE
    exit 1
}

N_check=$(echo "$@" | awk -F', ' '{ print NF-1 }')
if [ $N_check -lt 1 ]; then
    exit_with_err
fi

# Read args and spit on ','
IFS=', ' read -r -a array <<< "$@"
N=${#array[@]}

# Selection sort logic
for((i=0;i<N-1;i++));do
    min=${array[$i]}
    ind=$i

    for((j=i+1;j<N;j++));do
        if((array[j]<min));then
            min=${array[$j]}
            ind=$j
        fi
    done

    tmp=${array[$i]}
    array[$i]=${array[$ind]}
    array[$ind]=$tmp
done

# Join array with commas
str=$(printf ', %s' "${array[@]}")
str=${str:2}
echo $str

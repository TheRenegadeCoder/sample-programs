#!/bin/sh

counter=0

while [ $counter -lt 10 ]; do
	star=`expr $counter \* 2 + 1`
	space=`expr 10 - $counter`
	printf " %.0s" $(seq 1 $space)
	printf "*%.0s" $(seq 1 $star)
	echo
	counter=`expr $counter + 1`
done

counter=8

while [ $counter -gt -1 ]; do
	star=`expr $counter \* 2 + 1`
	space=`expr 10 - $counter`
	printf " %.0s" $(seq 1 $space)
	printf "*%.0s" $(seq 1 $star)
	echo
	counter=`expr $counter - 1`
done

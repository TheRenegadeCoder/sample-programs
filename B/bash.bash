#!/bin/bash

for i in {0..9}; do
	star=$(( $i * 2 + 1 ))
	space=$(( 10 - $i ))
	printf " %.0s" $(seq 1 $space)
	printf "*%.0s" $(seq 1 $star)
	echo
done

for i in {8..0}; do
	star=$(( $i * 2 + 1 ))
	space=$(( 10 - $i ))
	printf " %.0s" $(seq 1 $space)
	printf "*%.0s" $(seq 1 $star)
	echo
done

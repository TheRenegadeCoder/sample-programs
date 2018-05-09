#!/bin/bash

read -p "Enter any string: " string
strLength=${#string}

for ((i=$strLength-1;i>-1;i--)); 
do
    reverseStr+=${string:i:1}
done
echo $reverseStr
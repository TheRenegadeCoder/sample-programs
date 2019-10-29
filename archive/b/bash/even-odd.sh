#!/bin/bash
count=$1

[[ $count =~ ^[0-9]+$ && ((count > 0)) ]] || { echo "Usage: please input a number"; exit 1; }

rem=$(( $count % 2 ))
 
if [ $rem -eq 0 ]
then
    echo "Even"
else
    echo "Odd"
fi
    

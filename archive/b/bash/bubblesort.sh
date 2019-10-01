arr = (10 8 20 100 12) 
  
echo "Array in original order"
echo ${arr[*]} 
  
# Performing Bubble sort  
for ((i = 0; i<5; i++)) 
do
      
    for((j = i; j<5-i-1; j++)) 
    do
      
        if ((${arr[j]} > ${arr[$((j+1))]})) 
        then
            # swap 
            temp = ${arr[$j]} 
            arr[$j] = ${arr[$((j+1))]}   
            arr[$((j+1))] = $temp 
        fi
    done
done
  
echo "Array in sorted order :"
echo ${arr[*]} 

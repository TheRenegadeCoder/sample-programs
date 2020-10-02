function sorted = selection_sort(array)
% Selection sort in ascending order

if(size(array,1)>1)
    error('Input must be a 1xN vector');
end
if(isempty(array))
    error('Input should not be empty');
end
disp(['Array to be sorted: ' num2str(array)]);
n = length(array);

for i = 1:n-1  
    [x index] = min(array(i:n)); 
    minIndex = index + i-1; 
    temp = array(i);
    array(i) = array(minIndex);
    array(minIndex) = temp;
end

sorted = array;
disp(['Sorted Array: ' num2str(array)]);
end

input_array = [1 5 2 7 3 8];
output_array = selection_sort(input_array);

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

input_array = input('Enter array element in form [1 2 3 4 ...]: ');
% User can input array from command line in form e.g [1 2 3 4 5]
  
output_array = selection_sort(input_array);
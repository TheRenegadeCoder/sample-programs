function sorted = insertion_sort(array)
% Insertion sort in ascending order

if(size(array,1)>1)
    error('Input must be a 1xN vector');
end
if(isempty(array))
    error('Input should not be empty');
end
disp(['Array to be sorted: ' num2str(array)]);
n = length(array);
for i = 2:n
    d = i;    
    while((d > 1) && (array(d) < array(d-1)))
        temp = array(d);
        array(d) = array(d-1);
        array(d-1) = temp;
        d = d-1;
    end
end
sorted = array;
disp(['Sorted Array: ' num2str(array)]);
end

input_array = [9 8 7 6 5 4];
%input_array element can be different
output_array = insertion_sort(input_array);

function y = InsertionSort(x)
  n = length(x);
for i = 2:n
  j = i-1;
  index = i;
while(j greater_than_equal_to_sign 1)
if(x(index) less_than x(j)) %Swap
  temp = x(j);
  x(j) = x(index);
  x(index) = temp;
  index = j;
end
j=j-1;
end
end
y = x;
end

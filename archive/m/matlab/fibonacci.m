function f = fibonacci(n)

if ischar(n)
	error('Usage: please input the count of fibonacci numbers to output')
end

if n < 0
	error('Usage: please input a non-negative integer')
end

if not(n==round(n))
	error('Usage: please input an integer, not a floating point')
end


a(1) = 1;
a(2) = 1;


for i=1:n
  a(i+2)=a(i+1)+a(i);
end

f = mat2str(a);

end

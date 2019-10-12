function result=factorial(n)

if n<0
	error('Please input a non-negative integer')
end

if not(ischar(n))
	error('Please input a non-negative integer')
end

if isempty(n)=1
	error('Please input a non-negative integer')
end

x=1;

if n>0
	for i = 1:n
  
     		x=x*i;

	end
end

result = x
end

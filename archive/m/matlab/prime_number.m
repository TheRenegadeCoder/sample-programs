function result = prime_number(n)

if n < 0
	result = 'Please input a non-negative integer'
end

if not(ischar(n))
	result = 'Please input a non-negative integer'
end

if not(isempty(n)) = 1
	result = 'Please input a non-negative integer'
end

if not(~isinf(x) & floor(x) == x)
    result = 'Please input a non-negative integer'
end

if n == 0 | n == 1
    result = 'Neither Prime nor Composite'
end

m = 2;
isprime = 1;

while (m <= sqrt(n))
    if(rem(n, m) == 0)
        isprime = 0;
        break;
    end
    m = m + 1;
end

if(isprime == 1)
    result = 'Prime'
else
    result = 'Composite'

end
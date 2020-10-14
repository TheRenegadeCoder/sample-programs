/* ARG with source string named in REXX program invocation */
arg number
If (DATATYPE(number, 'W') == 0) then signal err
If (number < 0) then signal err
isPrime = 1
if \((number // 2 = 0) & (number \= 2) | (number == 1)) then
	do
		i = TRUNC(number / 2)
		do while(i > 3)
			if (number // i == 0) then
				isPrime = 0
			i = i - 1
		end
	end
else
	isPrime = 0

if (isPrime == 1) then
	say "Prime"
else
	say "Composite"
;exit

Err:
say 'Usage: please input a non-negative integer'; exit

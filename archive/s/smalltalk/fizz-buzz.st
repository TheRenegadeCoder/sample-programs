"Loop 1 to 100"
1 to: 100 do: [ :i |
	
	"If the number isn't divisible by 3 or 5, show the number"
	i \\ 3 = 0 ifFalse: [i \\ 5 = 0 ifFalse: [Transcript show: (i  printString); cr]].
	
	"If the number is divisible by 3 AND 5, show 'FizzBuzz'"
	i \\ 3 = 0 ifTrue: [i \\ 5 = 0 ifTrue: [Transcript show: 'FizzBuzz' ; cr]].

	"If the number is only divisible by 3, show 'Fizz'"
	i \\ 3 = 0 ifTrue: [i \\ 5 = 0 ifFalse: [Transcript show: 'Fizz' ; cr]].
	
	"If the number is only divisible by 5, show 'Buzz"
	i \\ 5 = 0 ifTrue: [i \\ 3 = 0 ifFalse: [Transcript show: 'Buzz' ; cr]].
	].
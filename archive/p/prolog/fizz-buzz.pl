fizzbuzz(N) :-
    between(1, N, X),
    (X mod 15 =:= 0 ->
        write('FizzBuzz'), nl
    ; X mod 3 =:= 0 ->
        write('Fizz'), nl
    ; X mod 5 =:= 0 ->
        write('Buzz'), nl
    ;
        write(X), nl
    ),
    X1 is X + 1,
    fizzbuzz(X1).

% To test FizzBuzz up to a certain number, you can use:
% ?- fizzbuzz(20).

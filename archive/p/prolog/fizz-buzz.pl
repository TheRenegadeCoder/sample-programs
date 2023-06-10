% Portions of this solution were derived through the assistance of ChatGPT.
:- initialization(main).

fizzbuzz(N) :-
    fizzbuzz_helper(1, N).

fizzbuzz_helper(X, N) :-
    X > N, !.
fizzbuzz_helper(X, N) :-
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
    fizzbuzz_helper(X1, N).

main() :-
    fizzbuzz(100),
    halt.
-module(fizz_buzz).
-export([start/0]).

% Run with: erl -noshell -run fizz_buzz -s init stop

start() ->
    fizz_buzz(1, 100).

fizz_buzz(N, Max) when N > Max -> [];
fizz_buzz(N, Max) when N rem 15 == 0 -> io:format("FizzBuzz~n", []), fizz_buzz(N+1, Max);
fizz_buzz(N, Max) when N rem 5 == 0 -> io:format("Buzz~n", []), fizz_buzz(N+1, Max);
fizz_buzz(N, Max) when N rem 3 == 0 -> io:format("Fizz~n", []), fizz_buzz(N+1, Max);
fizz_buzz(N, Max) -> io:format("~p~n", [N]), fizz_buzz(N+1, Max).

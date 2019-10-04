-module(fizz_buzz).
-export([fizz_buzz/1]).

-spec fizz_buzz(Number :: integer()) -> binary().
fizz_buzz(N) when N =:= 100 ->
    io:format("Buzz~n");
fizz_buzz(N) ->
    case N rem 3 of
        0 ->
            case N rem 5 of
                0 ->
                    io:format("FizzBuzz~n"),
                    fizz_buzz(N+1);
                _ ->
                    io:format("Fizz~n"),
                    fizz_buzz(N+1)
            end;
        _ ->
            case N rem 5 of
                0 ->
                    io:format("Buzz~n"),
                    fizz_buzz(N+1);
                _ ->
                    io:format("~w~n",[N]),
                    fizz_buzz(N+1)
            end
    end.

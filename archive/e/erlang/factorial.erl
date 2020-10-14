main([String]) ->
    try
        N = list_to_integer(String),
        F = factorial(N),
        io:format("~w~n", F)
    catch
        _:_ ->
            usage()
    end;
main(_) ->
    usage().
    
usage() ->
    io:format("Usage: please input a non-negative integer~n"),
    halt(1).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

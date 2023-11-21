-module(factorial).
-export([main/1]).

-spec start(Number :: integer()) -> integer().
start(N) 
    when N<0 ->
        usage();
start(0) ->
    factorial(1,1);
start(N) ->
    factorial(N,N).

convert_to_integer(Str) ->
    Result = catch string:to_integer(string:strip(Str)),
    case Result of
        {Int, Rest} when Rest == "" ->
            Int;
        _ ->
            usage()
    end.

main(Args) ->
    if
        length(Args) < 1 ->
            usage();
        true ->
            ok
    end,

    StrValue = lists:nth(1, Args),
    Value = convert_to_integer(StrValue),
    start(Value).

%%--------------------------------------------------------------------
%% Recursively multiply N times N-1 until N-1=1. Output Accumulator
%%--------------------------------------------------------------------
factorial(1,Acc) ->
    io:format("~w~n", [Acc]);
factorial(N,Acc) ->
    factorial(N-1, (N-1)*Acc).

usage() ->
    io:format("Usage: please input a non-negative integer~n"),
    erlang:halt().

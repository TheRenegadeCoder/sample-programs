-module(factorial).
-export([main/1]).

usage() ->
    io:format("Usage: please input a non-negative integer~n"),
    halt().

convert_to_integer(Str) ->
    Result = catch string:to_integer(string:strip(Str)),
    case Result of
        {Int, Rest} when Rest == "" ->
            {ok, Int};
        _ ->
            {error, 0}
    end.

main(Args) ->
    if
        length(Args) < 1 ->
            usage();
        true ->
            ok
    end,

    StrValue = lists:nth(1, Args),
    Value = case convert_to_integer(StrValue) of
        {ok, Int} ->
            Int;
        _ ->
            usage()
    end,

    if
        Value < 0 ->
            usage();
        true ->
            ok
    end,

    FValue = factorial(Value),
    io:format("~w~n", [FValue]).

%%--------------------------------------------------------------------
%% Recursively multiply N times N-1 until N <= 1
%%--------------------------------------------------------------------
factorial(N) ->
    if
        N =< 1 ->
            1;
        true ->
            N * factorial(N-1)
    end.

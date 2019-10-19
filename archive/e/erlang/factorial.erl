-module(factorial).
-export([start/1]).

-spec start(Number :: integer()) -> integer().
start(N) 
    when N<0;
         not is_integer(N) ->
    io:format("Usage: please input a non-negative integer~n");
start(0) ->
    factorial(1,1);
start(N) ->
    factorial(N,N).

%%--------------------------------------------------------------------
%% Recursively multiply N times N-1 until N-1=1. Output Accumulator
%%--------------------------------------------------------------------
factorial(1,Acc) ->
    io:format("~w~n", [Acc]);
factorial(N,Acc) ->
    factorial(N-1, (N-1)*Acc).
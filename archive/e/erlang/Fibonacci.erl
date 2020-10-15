% METHOD 1

-module(prog).
 
-export([main/0]).
 
fib(1,_,Res) -> 
    io:format("~B, ",[Res]);
fib(N,Prev,Res) when N > 1 -> 
    io:format("~B, ",[Res]),
    fib(N-1, Res, Res+Prev).
 
main() -> 
    fib(16,0,1),
    io:format("...~n").



% METHOD 2

fib(N) ->
    fib(N, 0, 1).

fib(0, _, B) -> B;
fib(N, A, B) ->
    io:format("~p~n", [B]),
    fib(N-1, B, A+B).
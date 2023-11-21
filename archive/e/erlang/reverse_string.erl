-module(reverse_string).
-export([main/1]).

-spec start(String :: string()) -> string().
%%--------------------------------------------------------------------
%% Reverse a given string
%%--------------------------------------------------------------------
start(String) ->
   lists:reverse(String).

main(Args) ->
    if
        length(Args) >= 1 ->
            Str = lists:nth(1, Args);
        true ->
            Str = ""
    end,

   ReverseStr = start(Str),
   io:format("~s~n", [ReverseStr]).

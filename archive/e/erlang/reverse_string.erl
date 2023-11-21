-module(reverse_string).
-export([main/1]).

%%--------------------------------------------------------------------
%% Reverse a given string
%%--------------------------------------------------------------------
reverse_string(String) ->
   lists:reverse(String).

main(Args) ->
    if
        length(Args) >= 1 ->
            Str = lists:nth(1, Args);
        true ->
            Str = ""
    end,

   ReverseStr = reverse_string(Str),
   io:format("~s~n", [ReverseStr]).

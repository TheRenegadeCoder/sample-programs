-module(bubble_sort).
-export([main/1]).

%% Run with: escript bubble_sort.erl <INPUT>

usage() ->
    io:format("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"~n"),
    halt().

convert_list_to_integers(Str) ->
    Values = string:tokens(Str, ","),
    convert_values(Values).

convert_values([]) ->
    [];
convert_values([ValueStr | Rest]) ->
    [convert_to_integer(ValueStr) | convert_values(Rest)].

convert_to_integer(Str) ->
    Result = catch string:to_integer(string:strip(Str)),
    case Result of
        {Int, Rest} when Rest == "" ->
            Int;
        _ ->
            usage()
    end.

bubble_sort(List) -> bubble_sort(List, [], false).

bubble_sort([A, B | T], Acc, _) when A > B ->
    bubble_sort([A | T], [B | Acc], true);
bubble_sort([A, B | T], Acc, Tainted) ->
    bubble_sort([B | T], [A | Acc], Tainted);
bubble_sort([A | T], Acc, Tainted) ->
    bubble_sort(T, [A | Acc], Tainted);
bubble_sort([], Acc, true) ->
    bubble_sort(lists:reverse(Acc));
bubble_sort([], Acc, false) ->
    lists:reverse(Acc).


handle_output([Num]) ->
    io:format("~p~n", [Num]);
handle_output([Num|NumList]) ->
    io:format("~p, ", [Num]),
    handle_output(NumList).

main(Args) ->
    if
        length(Args) < 1 ->
            usage();
        true ->
            ok
    end,

    StrValue = lists:nth(1, Args),
    Result = convert_list_to_integers(StrValue),
    if
        length(Result) < 2 ->
            usage();
        true ->
            ok
    end,

    SortedResult = bubble_sort(Result),
    handle_output(SortedResult).

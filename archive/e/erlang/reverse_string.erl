-module(reverse_string).
-export([start/1]).

-spec start(StringOrAtom :: list() | atom() | integer()) -> 
   list() | atom() | integer().
%%--------------------------------------------------------------------
%% Reverse a given string, atom, or integer
%%--------------------------------------------------------------------
start(String) when is_list(String)  ->
   lists:reverse(String);

start(Atom) when is_atom(Atom) ->
   list_to_atom(lists:reverse(atom_to_list(Atom)));

start(Number) when is_integer(Number) ->
   list_to_integer(lists:reverse(integer_to_list(Number))).
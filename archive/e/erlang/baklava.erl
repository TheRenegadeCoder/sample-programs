-module(baklava).
-export([start/1]).

-spec start(MaxWidth :: integer()) -> ok.
start(MaxWidth) ->
    baklava(MaxWidth, []),
    ok.

-spec baklava(MaxWidth :: integer(),
              Incrementor :: list()) -> ok.
%%--------------------------------------------------------------------
%% Recursively prints the top half of the baklava 
%%--------------------------------------------------------------------
baklava(MaxWidth, [_H|T] = Incrementor)  when MaxWidth =:= length(Incrementor) ->
    print((MaxWidth*2)+1, star),
    reverse_baklava(MaxWidth, T);
baklava(MaxWidth, Incrementor) ->
    print(MaxWidth-length(Incrementor), space),
    print((length(Incrementor)*2)+1, star),
    baklava(MaxWidth, [" " | Incrementor]).

-spec reverse_baklava(MaxWidth :: integer(),
                      Decrementor :: list()) -> ok.
%%--------------------------------------------------------------------
%% Recursively prints the bottom half of the baklava
%%--------------------------------------------------------------------
reverse_baklava(MaxWidth, []) ->
    print(MaxWidth, space),
    print(1, star);
reverse_baklava(MaxWidth, [_H|T] = Decrementor) ->
    print(MaxWidth-length(Decrementor), space),
    print((length(Decrementor)*2)+1, star),
    reverse_baklava(MaxWidth, T).

-spec print(Number :: integer(),
            Type :: star | space) -> ok.
%%--------------------------------------------------------------------
%% Recursively prints the specified Number of stars or spaces
%%--------------------------------------------------------------------
print(0,star) ->
    io:format("~n");
print(0,_) ->
    ok;
print(N, space) ->
    io:format(" "),
    print(N-1, space);
print(N, star) ->
    io:format("*"),
    print(N-1, star).

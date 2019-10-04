-module(baklava).
-export([start/1]).

-spec start(MaxWidth :: integer()) -> ok.
start(MaxWidth) ->
    baklava(MaxWidth, 0),
    ok.

-spec baklava(MaxWidth :: integer(),
              Incrementor :: integer()) -> ok.
%%--------------------------------------------------------------------
%% Recursively prints the top half of the baklava 
%%--------------------------------------------------------------------
baklava(MaxWidth, MaxWidth) ->
    print((MaxWidth*2)+1, star),
    reverse_baklava(MaxWidth, MaxWidth-1);
baklava(MaxWidth, Incrementor) ->
    print(MaxWidth-Incrementor, space),
    print((Incrementor*2)+1, star),
    baklava(MaxWidth, Incrementor+1).

-spec reverse_baklava(MaxWidth :: integer(),
                      Decrementor :: integer()) -> ok.
%%--------------------------------------------------------------------
%% Recursively prints the bottom half of the baklava
%%--------------------------------------------------------------------
reverse_baklava(MaxWidth, 0) ->
    print(MaxWidth, space),
    print(1, star);
reverse_baklava(MaxWidth, Decrementor) ->
    print(MaxWidth-Decrementor, space),
    print((Decrementor*2)+1, star),
    reverse_baklava(MaxWidth, Decrementor-1).

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

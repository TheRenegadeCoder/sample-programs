-module(baklava).
-export([start/1]).

-spec start(MaxWidth :: integer()) -> ok.
start(MaxWidth) ->
    baklava(MaxWidth),
    ok.

-spec baklava(MaxWidth :: integer()) -> ok.
baklava(MaxWidth) ->
    baklava(MaxWidth, []),
    ok.

-spec baklava(MaxWidth :: integer(), Incrementor :: list()) -> ok.
baklava(MaxWidth, [_H|T] = Incrementor)  when MaxWidth =:= length(Incrementor) ->
    % print (MaxWidth-Incementor) space(s), print (Incrementor*2+1) asterisk(s) 
    % io:format(" ~w", [(MaxWidth-length(Incrementor))]),
    print(MaxWidth-length(Incrementor), space),
    % io:format("*~w", [(length(Incrementor)*2)+1]),
    print((length(Incrementor)*2)+1, star),
    reverse_baklava(MaxWidth, T);
baklava(MaxWidth, Incrementor) ->
    % print (MaxWidth-Incementor) space(s), print (Incrementor*2+1) asterisk(s) 
    % io:format(" ~w", [(MaxWidth-length(Incrementor))]),
    print(MaxWidth-length(Incrementor), space),
    % io:format("*~w", [(length(Incrementor)*2)+1]),
    print((length(Incrementor)*2)+1, star),
    % call baklava(MaxWidth, Incrementor+1)
    baklava(MaxWidth, [" " | Incrementor]).

-spec reverse_baklava(MaxWidth :: integer(), Decrementor :: integer()) -> ok.
reverse_baklava(MaxWidth, []) ->
    % io:format(" ~w", [MaxWidth]),
    print(MaxWidth, space),
    % io:format("*~w", [(0*2)+1]),
    print(1, star);
reverse_baklava(MaxWidth, [_H|T] = Decrementor) ->
    % print (MaxWidth-Decrementor) space(s), print (Decrementor*2+1) asterisk(s) 
    % io:format(" ~w", [(MaxWidth-length(Decrementor))]),
    print(MaxWidth-length(Decrementor), space),
    % io:format("*~w", [(length(Decrementor)*2)+1]),
    print((length(Decrementor)*2)+1, star),
    % call baklava(MaxWidth, Decrementor-1)
    reverse_baklava(MaxWidth, T).

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

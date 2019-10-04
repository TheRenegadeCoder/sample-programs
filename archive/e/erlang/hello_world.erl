-module(hello_world).
-export([start/0]).

start() ->
   io:format("Hello, World!~n").

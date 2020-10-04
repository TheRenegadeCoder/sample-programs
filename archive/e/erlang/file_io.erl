-module(file_io). 
-export([start/0]). 

start() -> 
   {ok, Fd} = file:open("file.txt", [write]), 
   file:write(Fd,"Hello world!!!").

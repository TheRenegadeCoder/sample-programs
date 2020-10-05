;Some of th examples of string-capitalize usage
 (string-capitalize "elm 13c arthur;fig don't") ; "Elm 13c Arthur;Fig Don'T"
 (string-capitalize " hello ") ; " Hello "
 (string-capitalize "occlUDeD cASEmenTs FOreSTAll iNADVertent DEFenestraTION") ; "Occluded Casements Forestall Inadvertent Defenestration"
 (string-capitalize "kludgy-hash-search") ; "Kludgy-Hash-Search"
 (string-capitalize "DON'T!") ; "Don'T!"    ;not "Don't!"
 (string-capitalize "pipe 13a, foo16c") ; "Pipe 13a, Foo16c"
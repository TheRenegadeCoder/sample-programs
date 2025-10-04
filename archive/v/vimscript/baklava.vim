func! Baklava()
    for l:i in range(-10, 10)
        let l:numSpaces = abs(l:i)
        echo repeat(' ', l:numSpaces) . repeat('*', 21 - 2 * l:numSpaces)
    endfor
endfunc

func! Main()
    call Baklava()
endfunc

func! Reverse(str)
    return join(reverse(split(a:str, '\zs')), '')
endfunc

func! Main(...)
    echo Reverse(a:0 > 0 ? a:1 : '')
endfunc

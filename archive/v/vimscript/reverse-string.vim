func! Reverse(str)
    let l:r = join(reverse(split(a:str, '\zs')), '')
    call append(0, l:r)
endfunc

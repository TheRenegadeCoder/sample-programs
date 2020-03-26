func! Hello()
    call append(0, "Hello, World!")
endfunc

au BufEnter,BufReadPost * call Hello()

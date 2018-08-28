func! FizzBuzz()
    for l:i in range(1, 100)
        if l:i % 15 == 0
            let l:str = 'FizzBuzz'
        elseif l:i % 5 == 0
            let l:str = 'Buzz'
        elseif l:i % 3 == 0
            let l:str = 'Fizz'
        else
            let l:str = l:i
        endif

        call append(l:i-1, l:str)
    endfor

    " go to top of buffer
    normal gg
endfunc

au BufEnter,BufReadPost * call FizzBuzz()

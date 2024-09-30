do i = -10 to 10
    numSpaces = abs(i)
    say strRepeat(numSpaces, " ") || strRepeat(21 - 2 * numSpaces, "*")
end

strRepeat:
    arg n, s
    result = ""
    do while n > 0
        result = result || s
        n = n - 1
    end

    return result

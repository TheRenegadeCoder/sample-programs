Red [Title: "Bakalava"]

s: ""
repeat i 21 [
    numSpaces: i - 11
    if numSpaces < 0 [numSpaces: 0 - numSpaces]
    clear s
    insert/dup tail s " " numSpaces
    insert/dup tail s "*" (21 - (2 * numSpaces))
    print s
]

Red [Title: "Fibonacci"]

fibonacci: func[n] [

if n <= 0 [return 0]

if  n > 0 [
    a: 0
    b: 1
    i: 1
    loop n  [
    c: a + b
    a: b
    b: c
    print [i":" a]
    i: i + 1
        ]
    ]
    

;if  n = "" [print "Usage: please input the count of fibonacci numbers to output"]
;if  not integer? n [print "Usage: please input the count of fibonacci numbers to output"]

]
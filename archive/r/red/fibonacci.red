Red [Title: "Fibonacci"]

fibonacci: func[n] [

if n <= 0 [return 0]

if  n > 0 [
    a: 0
    b: 1
    print [1":" b]
    i: 2
    loop n - 1 [
    c: a + b
    a: b
    b: c
    print [i":"b]
    i: i + 1
        ]
    ]
    

;if  n = "" [print "Usage: please input the count of fibonacci numbers to output"]
;if  not integer? n [print "Usage: please input the count of fibonacci numbers to output"]

]
Red [Title: "Fibonacci"]

fibonacci: func[n] [

if n == 0 [return 0]
if n == "" [print "- Usage: please input the count of fibonacci numbers to output"]
if not integer? n [print "- Usage: please input the count of fibonacci numbers to output"]

if n > 0 [
    a: 0
    b: 1
    
    loop i 1 to n [
    c: a + b
    a: b
    b: c
    print i": "b
        ]
    ]
    
]

    
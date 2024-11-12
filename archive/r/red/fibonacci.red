Red [Title: "Fibonacci]

fibonacci: func[n][
    num1: 0
    num2: 1
    loop i 1 to n - 1 [
    
    num3: num1 + num2
    num1: num2
    num2: num3
    ]

    return num3
]


    
; Source: https://rosettacode.org/wiki/FizzBuzz#Red
Red [Title: "FizzBuzz"]

repeat i 100 [
    print case [
        i % 15 = 0 ["FizzBuzz"]
        i % 5 = 0 ["Buzz"]
        i % 3 = 0 ["Fizz"]
        true [i]
    ]
]

BEGIN {
    for (i = 1; i <= 100; i++) {
        result = ""
        if (i % 3 == 0) {
            result = result "Fizz"
        }

        if (i % 5 == 0) {
            result = result "Buzz"
        }

        if (!result) {
            result = result sprintf("%d", i)
        }

        print result
    }
}

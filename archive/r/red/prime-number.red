Red [Title: "Prime Number in Red"]

prime-number: func [number [integer!]] [
    either number <= 1 [
        print "Composite"
    ][
        found?: false
        limit: to integer! square-root number
        repeat i limit - 1 [
            if (number // (i + 1)) = 0 [
                print "Composite"
                found?: true
                break
            ]
        ]
        if not found? [print "Prime"]
    ]
]

main: func [arg [string!]] [

    arg: trim/with arg {'"}

    digit: charset "0123456789"
    if not parse arg [opt ["+" | "-"] some digit end] [
        print "Usage: please input a non-negative integer"
        exit
    ]

    either attempt [arg: to-integer arg][
    ][
        print "Usage: please input a non-negative integer"
        exit
    ]

    if negative? arg [
        print "Usage: please input a non-negative integer"
        exit
    ]

    prime-number arg
]

main system/script/args
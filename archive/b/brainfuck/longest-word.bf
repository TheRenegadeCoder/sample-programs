[
    Source for comparing two numbers:
    https://stackoverflow.com/questions/6168584/brainfuck-compare-2-numbers-as-greater-than-or-less-than

    Source for printing memory value as number:
    https://esolangs.org/wiki/Brainfuck_algorithms#Print_value_of_cell_x_as_number_.288-bit.29

    Source for error message
    https://copy.sh/brainfuck/text.html
]
; Mem 0 = 1 (indicate no input)
+
; Mem 1 = 0 (word length)
>
; Mem 2 = 0 (max word length)
>
; Mem 3 = input; Loop while input not null
>,[
    ; Mem 5 = 1 (assume whitespace)
    >>+
    ; Mem 0 = 0 (indicate input)
    <<<<<[-]
    ; Sub 9 from Mem 3; If not zero (not tab)
    >>>---------[
        ; Dec Mem 3; If not zero (not newline)
        -[
            ; Sub 3 from Mem 3; If not zero (not carriage return)
            ---[
                ; Sub 19 from Mem 3; If not zero (not space)
                >[-]+++[            ; Mem 4 = 3
                    <------         ; Sub 6 from Mem 3
                    >-              ; Dec Mem 4
                ]
                <-                  ; Dec Mem 3
                [
                    ; Inc Mem 1 (word length)
                    <<+
                    ; Copy Mem 1 (word length) to Mem 7 and Mem 9; Mem 1 = 0
                    [
                        >>>>>>+     ; Inc Mem 7
                        >>+         ; Inc Mem 9
                        <<<<<<<<-   ; Dec Mem 1
                    ]
                    ; Copy Mem 2 (max word length) to Mem 6 and 10; Mem 2 = 0
                    >[
                        >>>>+       ; Inc Mem 6
                        >>>>+       ; Inc Mem 10
                        <<<<<<<<-   ; Dec Mem 2
                    ]
                    ; Mem 3 = 0
                    >[-]
                    ; Mem 4 = 1
                    >+
                    ; Mem 5 = 0
                    >-
                    ; Mem 8 = 0
                    >>>[-]
                    ; If Mem 6 (max word length) less than Mem 7 (word length);
                    ; pointer is 6; Mem 6 is 0; Mem 7 is word length minus max word length;
                    ; else pointer is 5; Mem 5 is 0; Mem 6 is max word length minus word length
                    <+<+[->-[>]<<]
                    ; If less than
                    <<[
                        ; Increment Mem 10 (max word length)
                        >>>>>>+
                        ; Move pointer to Mem 3
                        <<<<<<<
                    ]
                    ; Mem 6 = 0
                    >>>[-]
                    ; Mem 7 = 0
                    >[-]
                    ; Copy Mem 9 (word length) back to Mem 1; Mem 9 = 0
                    >>[
                        <<<<<<<<+   ; Inc Mem 1
                        >>>>>>>>-   ; Dec Mem 9
                    ]
                    ; Copy Mem 10 (max word length) back to Mem 2; Mem 10 = 0
                    >[
                        <<<<<<<<+   ; Inc Mem 2
                        >>>>>>>>-   ; Dec Mem 10
                    ]
                    ; Set pointer to Mem 3
                    <<<<<<<
                ]
            ]
        ]
    ]

    ; If Mem 5 not zero (whitespace)
    >>[
        ; Mem 1 = 0 (word length)
        <<<<[-]

        ; Mem 5 = 0
        >>>>[-]
    ]
    ; Mem 4 = 0
    <[-]
    ; Mem 3 = input
    <,
]
; If Mem 2 (max word length) not zero
<[
    ; Display it as a number
    >>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-
    <+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++
    <]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<
    ; Clear it
    [-]
]
; If no input; display error message
<<[
    [-]
    -[--->+<]>.
    +[--->+<]>+.
    ++[->+++<]>++.
    ++++++.
    --.
    +++[->+++<]>++.
    [-->+<]>+++.
    [-->+++++++<]>.
    ----.
    -------.
    ----.
    --[--->+<]>--.
    ++++[->+++<]>.
    --[--->+<]>-.
    [-->+++++++<]>.
    ++.
    ---.
    +++++++.
    [------>+<]>.
    -----.
    +.
    --[--->+<]>-.
    [->+++<]>+.
    -[->+++<]>.
    ---[->++++<]>-.
    +.
    --.
    ---------.
    +++++.
    -------.
    [-]
]

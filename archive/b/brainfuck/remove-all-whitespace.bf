[
    Source for error message text:
    https://copy.sh/brainfuck/text.html

]
; Mem 0 = 1 (indicate no input)
+
; Mem 1 = input; Loop while input not null
>,[
    ; Mem 0 = 0 (indicate input)
    <[-]
    ; Mem 2 = input; Mem 3 = input; Mem 1 = 0
    >>[-]   ; Mem 2 = 0
    >[-]    ; Mem 3 = 0
    <<[
        >+  ; Inc Mem 2
        >+  ; Mem Mem 3
        <<- ; Dec Mem 1
    ]
    ; If input is not tab (9);
    >>---------[    ; Sub 9 from Mem 3
        ; If input is not newline (10):
        -[    ; Dec Mem 3
        ; If input is not carriage return (13);
            ---[    ; Sub 3 from Mem 3
                ; If input is not space (32);
                >+++[       ; Mem 4 = 3
                <------  ; Sub 6 from Mem 3
                >-       ; Dec Mem 4
                ]
                <-[         ; Dec Mem 3
                    ; Display input (Mem 2)
                    <.
                    ; Mem 3 = 0
                    >[-]
                ]
            ]
        ]
    ]
    ; Mem 1 = input
    <<,
]
; If no input; display error message
<[
    [-]
    >[-]<
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

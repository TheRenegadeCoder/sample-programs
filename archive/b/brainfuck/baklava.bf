; Mem 1 = 7; Mem 2 = 42 (star); Mem 3 = 35; Mem 4 = 7
+++++++         ; Mem 0 = 7
[
    >+          ; Inc Mem 1
    >++++++     ; Add 6 to Mem 2
    >+++++      ; Add 5 to Mem 3
    >+          ; Inc Mem 4
    <<<<-       ; Dec Mem 0
]
; Mem 1 = 10 (newline); Mem 3 = 32 (space); Mem 4 = 11
>+++            ; Add 3 to Mem 1
>>---           ; Sub 3 from Mem 3
>++++           ; Add 4 to Mem 4
[
    ; Dec Mem 4
    -
    ; Display Mem 4 spaces
    ; Mem 5 = Mem 4
    ; Mem 6 = 21 minus 2 * Mem 4
    >>>+++++++  ; Mem 7 = 7
    [
        <+++    ; Add 3 to Mem 6
        >-      ; Dec Mem 7
    ]
    <<<
    [
        <.      ; Display space (Mem 3)
        >>+     ; Inc Mem 5
        >--     ; Sub 2 from Mem 6
        <<-     ; Dec Mem 4
    ]
    ; Display Mem 6 stars
    >>
    [
        <<<<.   ; Display star (Mem 2)
        >>>>-   ; Dec Mem 6
    ]
    ; Display newline (Mem 1)
    <<<<<.
    ; Mem 4 = Mem 5
    >>>>
    [
        <+      ; Inc Mem 4
        >-      ; Dec Mem 5
    ]
    <
]
; Mem 4 = 10
++++++++++
[
    ; Dec Mem 4
    -
    ; Mem 5 = 10 minus Mem 4
    ; Mem 6 = 1 plus 2 * Mem 4
    >++++++++++ ; Mem 5 = 10
    >+          ; Mem 6 = 1
    <<
    [
        >-      ; Dec Mem 5
        >++     ; Add 2 to Mem 6
        <<-     ; Dec Mem 4
    ]
    ; Display Mem 5 spaces
    ; Mem 4 = 10 minus Mem 5
    ++++++++++  ; Mem 4 = 10
    >
    [
        <<.     ; Display Mem 3 (space)
        >-      ; Dec Mem 4
        >-      ; Dec Mem 5
    ]
    ; Display Mem 6 stars
    >
    [
        <<<<.   ; Display Mem 2 (star)
        >>>>-   ; Dec Mem 6
    ]
    ; Display newline (Mem 1)
    <<<<<.
    >>>
]

PROC usage = VOID: (
    printf(($gl$, "Usage: please provide a mode and a string to encode/decode"))
);

STRING base64 chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"[@0];
MODE DECODE_RESULTS = STRUCT(BOOL valid, STRING result);

PROC base64 encode = (STRING s) STRING:
(
    STRING result := "";
    INT s len = UPB s;
    INT n1, n2, n3;
    FOR n BY 3 TO s len
    DO
        n1 := ABS s[n];
        n2 := (n + 1 <= s len | ABS s[n + 1] | 0);
        n3 := (n + 2 <= s len | ABS s[n + 2] | 0);
        result +:= base64 chars[ABS (BIN n1 SHR 2)];
        result +:= (base64 chars[ABS (((BIN n1 SHL 4) OR (BIN n2 SHR 4)) AND 16r3f)]);
        result +:= (
            n + 1 <= s len | 
            base64 chars[ABS (((BIN n2 SHL 2) OR (BIN n3 SHR 6)) AND 16r3f)]
            | "="
        );
        result +:= (n + 2 <= s len | base64 chars[ABS (BIN n3 AND 16r3f)] | "=")
    OD;

    result
);

PROC base64 decode = (STRING s) DECODE_RESULTS:
(
    STRING result := "";
    INT s len := UPB s;
    INT pad count := count trailing pads(s);
    BOOL valid := s len MOD 4 = 0 AND pad count <= 2;

    INT n1, n2, n3, n4;
    s len -:= pad count;
    FOR n BY 4 TO s len
    WHILE valid
    DO
        n1 := index of(s[n], base64 chars);
        n2 := index of(s[n + 1], base64 chars);
        n3 := (n + 2 <= s len | index of(s[n + 2], base64 chars) | 0);
        n4 := (n + 3 <= s len | index of(s[n + 3], base64 chars) | 0);
        valid := n1 >= 0 AND n2 >= 0 AND n3 >= 0 AND n4 >= 0;
        IF valid
        THEN
            result +:= REPR ABS ((BIN n1 SHL 2) OR (BIN n2 SHR 4));
            result +:= (
                n + 1 <= s len |
                REPR ABS (((BIN n2 SHL 4) OR (BIN n3 SHR 2)) AND 16rff) |
                ""
            );
            result +:= (
                n + 2 <= s len |
                REPR ABS (((BIN n3 SHL 6) OR BIN n4) AND 16rff) |
                ""
            )
        FI
    OD;

    DECODE_RESULTS(valid, result)
);

PROC count trailing pads = (STRING s) INT:
(
    INT s len := UPB s;
    INT n := s len;
    INT pad count := 0;
    WHILE n >= 1 AND n <= s len AND s[n] = "="
    DO
        pad count +:= 1;
        n -:= 1
    OD;

    pad count
);

PROC index of = (CHAR c, STRING s) INT:
(
    INT start index = LWB s;
    INT result := start index - 1;
    FOR n FROM start index TO UPB s
    WHILE result < start index
    DO
        IF s[n] = c
        THEN
            result := n
        FI
    OD;

    result
);

# Parse command-line arguments #
STRING mode := argv(4);
STRING s := argv(5);
IF UPB s = 0
THEN
    usage;
    stop
FI;

STRING result;
IF mode = "encode"
THEN
    result := base64 encode(s)
ELIF mode = "decode"
THEN
    DECODE_RESULTS decode result := base64 decode(s);
    IF NOT (valid OF decode result)
    THEN
        usage;
        stop
    FI;

    result := result OF decode result
ELSE
    usage;
    stop
FI;

printf(($gl$, result))

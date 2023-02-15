COMMENT
Find longest palindromic string using matching array
Source: https://www.geeksforgeeks.org/longest-palindromic-substring-using-dynamic-programming/
COMMENT
PROC longest palindromic substring = (STRING s) STRING:
(
    # Allocate array indicating whether there is a character match #
    # between two characters #
    INT n := UPB s;
    HEAP [n, n]BOOL matches;

    # Indicate all length 1 strings match and everything else does not #
    FOR i TO n
    DO
        FOR j TO n
        DO
            matches[i, j] := FALSE
        OD;

        matches[i, i] := TRUE
    OD;

    # Convert string to lowercase #
    STRING t;
    FOR i TO n
    DO
        t +:= tolower(s[i])
    OD;

    # Find all length 2 matches #
    INT start := 1;
    INT max len := 1;
    FOR i TO n - 1
    DO
        IF t[i] = t[i + 1]
        THEN
            matches[i, i + 1] := TRUE;
            IF max len < 2
            THEN
                start := i;
                max len := 2
            FI
        FI
    OD;

    # Find all length 3 or higher matches #
    INT j;
    FOR len FROM 3 TO n
    DO
        # Loop through each starting character #
        FOR i TO n - len + 1
        DO
            # If match for one character in from start and end characters #
            # and start and end characters match, set match for start and #
            # end characters, and update max length #
            j := i + len - 1;
            IF matches[i + 1, j - 1] AND t[i] = t[j]
            THEN
                matches[i, j] := TRUE;
                IF len > max len
                THEN
                    max len := len;
                    start := i
                FI
            FI
        OD
    OD;

    s[start:start + max len - 1]
);

PROC usage = VOID: printf(($gl$, "Usage: please provide a string that contains at least one palindrome"));

# Error if 1st command-line argument is missing is empty #
STRING s := argv(4);
IF UPB(s) = 0
THEN
    usage;
    stop
FI;

# Get longest palindromic substring. Error if none found #
STRING longest := longest palindromic substring(s);
IF UPB(longest) < 2
THEN
    usage;
    stop
FI;

# Show longest palindromic substring #
printf(($gl$, longest))

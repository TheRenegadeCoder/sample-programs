MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);
MODE PARSEINTLIST_RESULT = STRUCT(BOOL valid, REF []INT values);

PROC parse int = (REF STRING s) PARSEINT_RESULT:
(
    BOOL valid := FALSE;
    REAL r := 0.0;
    INT n := 0;
    STRING leftover;

    # Associate string with a file #
    FILE f;
    associate(f, s);

    # On end of input, exit if valid number not seen. Otherwise ignore it #
    on logical file end(f, (REF FILE dummy) BOOL:
        (
            IF NOT valid THEN done FI;
            TRUE
        )
    );

    # Exit if value error #
    on value error(f, (REF FILE dummy) BOOL: done);

    # Convert string to real number #
    get(f, r);

    # If real number is in range of an integer, convert to integer. Indicate integer is valid if same as real #
    IF ABS r <= max int
    THEN
        n := ENTIER(r);
        valid := (n = r)
    FI;

    # Get leftover string #
    get(f, leftover);

done:
    close(f);
    PARSEINT_RESULT(valid, n, leftover)
);

PROC count list items = (STRING s) INT:
(
    INT count := 1;
    FOR k TO UPB s
    DO
        IF s[k] = ","
        THEN
            count +:= 1
        FI
    OD;

    count
);

PROC parse int list = (REF STRING s) PARSEINTLIST_RESULT:
(
    BOOL valid := FALSE;
    STRING leftover := s;
    INT num list items = count list items(s);
    HEAP [num list items]INT values;

    # Repeat while valid value #
    FOR k TO num list items
    DO
        # Get next integer value and update leftover string #
        PARSEINT_RESULT result = parse int(leftover);
        valid := valid OF result;
        leftover := leftover OF result;

        # Append the integer value to list #
        values[k] := value OF result;

        # Do nothing if end of string #
        IF leftover = ""
        THEN
            SKIP
        # Skip comma if leftover string starts with comma #
        ELIF leftover[1] = ","
        THEN
            leftover := leftover[2:]
        # Otherwise indicate invalid #
        ELSE
            valid := FALSE
        FI
    UNTIL NOT valid
    OD;

    PARSEINTLIST_RESULT(valid, values)
);

PROC usage = VOID: printf(($gl$, "Usage: please provide a list of profits and a list of deadlines"));

# Job details #
MODE JOB = STRUCT(INT id, INT profit, INT deadline);

# Compare 2 jobs #
OP <= = (JOB job1, JOB job2) BOOL:
(
    # Prioritize by profit, then deadline #
    (profit OF job1 /= profit OF job2 | profit OF job1 - profit OF job2 > 0 | deadline OF job1 - deadline OF job2 >= 0)
);

COMMENT
Source: https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
COMMENT
PROC quick sort = (REF []JOB values) VOID:
(
    quick sort rec(values, 1, UPB values)
);

PROC quick sort rec = (REF []JOB values, INT lo, INT hi) VOID:
(
    IF lo < hi AND lo >= 1
    THEN
        # Partition array and get pivot value #
        INT p := partition(values, lo, hi);

        # Sort left side of partition #
        quick sort rec(values, lo, p - 1);

        # Sort right side of partition #
        quick sort rec(values, p + 1, hi)
    FI
);

PROC partition = (REF []JOB values, INT lo, INT hi) INT:
(
    # Choose last value as pivot #
    JOB pivot = values[hi];

    # Set temporary pivot index #
    INT i := lo - 1;

    # Swap elements less than or equal to pivot, and increment temporary index #
    FOR j FROM lo TO hi - 1
    DO
        IF values[j] <= pivot
        THEN
            i +:= 1;
            swap(values, i, j)
        FI
    OD;

    # Move pivot to correct position #
    i +:= 1;
    swap(values, i, hi);

    i
);

PROC swap = (REF []JOB values, INT a, INT b) VOID:
(
    JOB temp := values[a];
    values[a] := values[b];
    values[b] := temp
);

PROC max = (INT a, INT b) INT: (a > b | a | b);

COMMENT
Job sequencing with deadlines
Source: https://www.techiedelight.com/job-sequencing-problem-deadlines/
COMMENT
PROC job sequencing = (REF []INT profits, REF []INT deadlines) REF []JOB:
(
    # Set up job details and longest deadline #
    INT n = UPB profits;
    HEAP [n]JOB jobs;
    INT longest deadline := 0;
    FOR k TO n
    DO
        jobs[k] := JOB(k, profits[k], deadlines[k]);
        longest deadline := max(longest deadline, deadlines[k])
    OD;

    # Initialize job slots #
    HEAP [longest deadline]JOB slots;
    FOR k TO longest deadline
    DO
        slots[k] := JOB(0, 0, 0)
    OD;

    # Sort jobs by profit then deadline #
    quick sort(jobs);

    FOR i TO n
    DO
        # For each job, see if there is available slot at or before the deadline #
        # if so, store this job in that slot #
        BOOL slot found := FALSE;
        FOR j FROM deadline OF jobs[i] DOWNTO 1
        WHILE NOT slot found
        DO
            IF id OF slots[j] < 1
            THEN
                slots[j] := jobs[i];
                slot found := TRUE
            FI
        OD
    OD;

    slots
);

# Get total profit #
PROC get total profit = (REF []JOB jobs) INT:
(
    INT total := 0;
    FOR k TO UPB jobs
    DO
        total +:= profit OF jobs[k]
    OD;

    total
);

# Parse 1st command-line argument #
STRING s := argv(4);
PARSEINTLIST_RESULT list result := parse int list(s);
REF []INT profits := values OF list result;
IF NOT valid OF list result
THEN
    usage;
    stop
FI;

# Parse 2nd command-line argument #
s := argv(5);
list result := parse int list(s);
REF []INT deadlines := values OF list result;
IF NOT valid OF list result OR UPB deadlines /= UPB profits
THEN
    usage;
    stop
FI;

# Get job sequence #
REF []JOB sequence := job sequencing(profits, deadlines);

# Get total profit and display #
INT total profit := get total profit(sequence);
printf(($gl$, whole(total profit, 0)))

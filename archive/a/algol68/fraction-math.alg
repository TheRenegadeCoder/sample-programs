MODE PARSEINT_RESULT = STRUCT(BOOL valid, INT value, STRING leftover);

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

PROC usage = VOID: printf(($gl$, "Usage: ./fraction-math operand1 operator operand2"));

# Fraction structure and operators to extract numerator and demoninator #
MODE FRACTION = STRUCT(INT num, INT den);
OP NUM = (FRACTION f) INT: num OF f;
OP DEN = (FRACTION f) INT: den OF f;

COMMENT
Greatest common denominator using Euclidean algorithm
Source: https://en.wikipedia.org/wiki/Euclidean_algorithm#Implementations

NOTE: This uses tail recursion
COMMENT
OP GCD = (INT a, INT b) INT:
(
    IF b = 0
    THEN
        ABS a
    ELSE
        b GCD (a MOD b)
    FI
);
PRIO GCD = 8;

# Fraction reduction #
PROC reduce = (INT n, INT d) FRACTION:
(
    IF d = 0
    THEN
        put(stand error, ("Division by 0", newline));
        stop
    FI;

    COMMENT
    Reduce by dividing numerator and denominator by greatest common denominator,
    and adjust sign of numerator and denominator as follows:

    n  d  sign n  sign d
    +  +     +       +
    +  -     -       +
    -  +     -       +
    -  -     +       +
    COMMENT
    INT g = n GCD d;
    FRACTION(SIGN d * n OVER g, ABS d OVER g)
);

# Fraction addition and subtraction #
# n1/d1 +/- n2/d2 = (n1*d2 +/- n2*d1) / (d1*d2) #
OP + = (FRACTION f1, FRACTION f2) FRACTION: (
    reduce(NUM f1 * DEN f2 + NUM f2 * DEN f1, DEN f1 * DEN f2)
);
OP - = (FRACTION f1, FRACTION f2) FRACTION: (
    reduce(NUM f1 * DEN f2 - NUM f2 * DEN f1, DEN f1 * DEN f2)
);

# Fraction multiplication #
# n1/d1 * n2/d2 = (n1*n2) / (d1*d2) #
OP * = (FRACTION f1, FRACTION f2) FRACTION: (
    reduce(NUM f1 * NUM f2, DEN f1 * DEN f2)
);

# Fraction division #
# (n1/d1) / (n2/d2) = (n1*d2) / (n2*d1) #
OP / = (FRACTION f1, FRACTION f2) FRACTION: (
    reduce(NUM f1 * DEN f2, NUM f2 * DEN f1)
);

# Fraction comparison #
# n1/d1 OP n2/d2 = n1*d2 OP n2*d1 #
# where: OP is some comparision operation #
OP CMP = (FRACTION f1, FRACTION f2) INT: (
    NUM f1 * DEN f2 - NUM f2 * DEN f1
);
PRIO CMP = 8;

OP > = (FRACTION f1, FRACTION f2) BOOL: f1 CMP f2 > 0;
OP >= = (FRACTION f1, FRACTION f2) BOOL: f1 CMP f2 >= 0;
OP < = (FRACTION f1, FRACTION f2) BOOL: f1 CMP f2 < 0;
OP <= = (FRACTION f1, FRACTION f2) BOOL: f1 CMP f2 <= 0;
OP = = (FRACTION f1, FRACTION f2) BOOL: f1 CMP f2 = 0;
OP /= = (FRACTION f1, FRACTION f2) BOOL: f1 CMP f2 /= 0;

# Parse fraction #
MODE PARSEFRACTION_RESULT = STRUCT(FRACTION value, BOOL valid);
PROC parse fraction = (REF STRING s) PARSEFRACTION_RESULT:
(
    # Parse numerator #
    PARSEINT_RESULT result := parse int(s);
    BOOL valid := valid OF result;
    INT n := value OF result;
    STRING leftover := leftover OF result;

    # Assume denominator is 1 #
    INT d := 1;

    # If numerator is valid and leftover starts with "/", parse denominator #
    IF valid AND (leftover /= "" ANDF leftover[1] = "/")
    THEN
        leftover := leftover[2:];
        result := parse int(leftover);
        valid := valid OF result;
        d := value OF result;
        leftover := leftover OF result
    FI;

    # Invalid if leftover string is not empty #
    IF leftover /= ""
    THEN
        valid := FALSE
    FI;

    PARSEFRACTION_RESULT(FRACTION(n, d), valid)
);

# Do fraction math #
MODE FRACTIONRESULT = UNION(FRACTION, BOOL);
PROC fraction math = (FRACTION f1, STRING op, FRACTION f2) FRACTIONRESULT:
(
    IF op = "+" THEN f1 + f2
    ELIF op = "-" THEN f1 - f2
    ELIF op = "*" THEN f1 * f2
    ELIF op = "/" THEN f1 / f2
    ELIF op = ">" THEN f1 > f2
    ELIF op = ">=" THEN f1 >= f2
    ELIF op = "<" THEN f1 < f2
    ELIF op = "<=" THEN f1 <= f2
    ELIF op = "==" THEN f1 = f2
    ELIF op = "!=" THEN f1 /= f2
    ELSE
        put(stand error, ("Invalid operator ", op, newline));
        stop
    FI
);

# Show fraction result #
PROC show fraction result = (FRACTIONRESULT result) VOID:
(
    CASE result IN
        (FRACTION f): printf(($g"/"gl$, whole(NUM f, 0), whole(DEN f, 0))),
        (BOOL b): printf(($gl$, (b | "1" | "0")))
    ESAC
);

# Parse 1st and 3rd command-line argument #
[2]FRACTION fractions;
STRING s;
[2]INT arg nums := (4, 6);
FOR k TO 2
DO
    s := argv(arg nums[k]);
    PARSEFRACTION_RESULT result := parse fraction(s);
    fractions[k] := value OF result;

    # If invalid, extra characters, exit #
    IF NOT (valid OF result)
    THEN
        usage;
        stop
    FI
OD;

# Get 2nd command-line argument. If empty, exit #
STRING op := argv(5);
IF UPB op = 0
THEN
    usage;
    stop
FI;

# DO fraction math and show result #
FRACTIONRESULT fraction result := fraction math(fractions[1], op, fractions[2]);
show fraction result(fraction result)

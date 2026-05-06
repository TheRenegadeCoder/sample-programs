MODULE FractionMath;

FROM STextIO IMPORT WriteString, WriteLn, WriteChar;
FROM NumberIO IMPORT WriteInt, WriteCard;
FROM TextIO IMPORT ReadToken;
FROM ProgramArgs IMPORT NextArg, IsArgPresent, ArgChan;
FROM StrLib IMPORT StrEqual;

TYPE
    Fraction = RECORD
        num: INTEGER;
        den: INTEGER;
    END;

PROCEDURE Usage;
BEGIN
    WriteString("Usage: ./fraction-math operand1 operator operand2");
    WriteLn;
END Usage;

PROCEDURE ReadArg(VAR s: ARRAY OF CHAR): BOOLEAN;
BEGIN
  NextArg;

  IF IsArgPresent() THEN
    ReadToken(ArgChan(), s);
    RETURN TRUE;
  END;

  RETURN FALSE;
END ReadArg;

PROCEDURE GCD(a, b: INTEGER): INTEGER;
VAR t: INTEGER;
BEGIN
    IF a < 0 THEN a := -a END;
    IF b < 0 THEN b := -b END;

    WHILE b # 0 DO
        t := b;
        b := a MOD b;
        a := t;
    END;

    RETURN a;
END GCD;

PROCEDURE Normalize(VAR f: Fraction);
VAR g: INTEGER;
BEGIN
    IF f.den = 0 THEN
        HALT;
    END;

    g := GCD(f.num, f.den);
    f.num := f.num DIV g;
    f.den := f.den DIV g;

    IF f.den < 0 THEN
        f.num := -f.num;
        f.den := -f.den;
    END;
END Normalize;

PROCEDURE ParseFraction(s: ARRAY OF CHAR; VAR f: Fraction): BOOLEAN;
VAR i, n, d, sign: INTEGER; ok: BOOLEAN;
BEGIN
    ok := FALSE;
    n := 0; d := 0; sign := 1;

    i := 0;

    (* parse numerator *)
    IF s[i] = '-' THEN
        sign := -1; INC(i);
    END;

    WHILE (s[i] >= '0') & (s[i] <= '9') DO
        n := n * 10 + INTEGER(ORD(s[i]) - ORD('0'));
        INC(i);
    END;

    IF s[i] # '/' THEN RETURN FALSE END;
    INC(i);

    (* parse denominator *)
    WHILE (s[i] >= '0') & (s[i] <= '9') DO
        d := d * 10 + INTEGER(ORD(s[i]) - ORD('0'));
        INC(i);
    END;

    f.num := sign * n;
    f.den := d;

    Normalize(f);
    RETURN TRUE;
END ParseFraction;

PROCEDURE Add(a, b: Fraction): Fraction;
VAR r: Fraction;
BEGIN
    r.num := a.num * b.den + b.num * a.den;
    r.den := a.den * b.den;
    Normalize(r);
    RETURN r;
END Add;

PROCEDURE Sub(a, b: Fraction): Fraction;
VAR r: Fraction;
BEGIN
    r.num := a.num * b.den - b.num * a.den;
    r.den := a.den * b.den;
    Normalize(r);
    RETURN r;
END Sub;

PROCEDURE Mul(a, b: Fraction): Fraction;
VAR r: Fraction;
BEGIN
    r.num := a.num * b.num;
    r.den := a.den * b.den;
    Normalize(r);
    RETURN r;
END Mul;

PROCEDURE Div(a, b: Fraction): Fraction;
VAR r: Fraction;
BEGIN
    IF b.num = 0 THEN HALT END;
    r.num := a.num * b.den;
    r.den := a.den * b.num;
    Normalize(r);
    RETURN r;
END Div;

PROCEDURE Cmp(a, b: Fraction): INTEGER;
VAR lhs, rhs: INTEGER;
BEGIN
    lhs := a.num * b.den;
    rhs := b.num * a.den;

    IF lhs > rhs THEN RETURN 1 END;
    IF lhs < rhs THEN RETURN -1 END;
    RETURN 0;
END Cmp;

PROCEDURE Eq(a, b: Fraction): INTEGER;
BEGIN IF Cmp(a,b) = 0 THEN RETURN 1 ELSE RETURN 0 END; END Eq;

PROCEDURE Ne(a, b: Fraction): INTEGER;
BEGIN IF Cmp(a,b) # 0 THEN RETURN 1 ELSE RETURN 0 END; END Ne;

PROCEDURE Gt(a, b: Fraction): INTEGER;
BEGIN IF Cmp(a,b) > 0 THEN RETURN 1 ELSE RETURN 0 END; END Gt;

PROCEDURE Lt(a, b: Fraction): INTEGER;
BEGIN IF Cmp(a,b) < 0 THEN RETURN 1 ELSE RETURN 0 END; END Lt;

PROCEDURE Ge(a, b: Fraction): INTEGER;
BEGIN IF Cmp(a,b) >= 0 THEN RETURN 1 ELSE RETURN 0 END; END Ge;

PROCEDURE Le(a, b: Fraction): INTEGER;
BEGIN IF Cmp(a,b) <= 0 THEN RETURN 1 ELSE RETURN 0 END; END Le;

PROCEDURE PrintFraction(f: Fraction);
BEGIN
    WriteInt(f.num, 0);
    WriteString("/");
    WriteInt(f.den, 0);
    WriteLn;
END PrintFraction;

VAR
  aStr, op, bStr: ARRAY [0..63] OF CHAR;
  a, b, r: Fraction;
  ok1, ok2, found: BOOLEAN;

BEGIN
    IF ~(ReadArg(aStr) AND ReadArg(op) AND ReadArg(bStr)) THEN
        Usage;
        RETURN;
    END;

    IF ~(ParseFraction(aStr, a) AND ParseFraction(bStr, b)) THEN
        Usage;
        RETURN;
    END;

    found := FALSE;

    IF    StrEqual(op, "+")  THEN PrintFraction(Add(a, b))
    ELSIF StrEqual(op, "-")  THEN PrintFraction(Sub(a, b))
    ELSIF StrEqual(op, "*")  THEN PrintFraction(Mul(a, b))
    ELSIF StrEqual(op, "/")  THEN PrintFraction(Div(a, b))
    
    ELSIF StrEqual(op, "==") THEN WriteInt(Eq(a, b), 1)
    ELSIF StrEqual(op, "!=") THEN WriteInt(Ne(a, b), 1)
    ELSIF StrEqual(op, ">")  THEN WriteInt(Gt(a, b), 1)
    ELSIF StrEqual(op, "<")  THEN WriteInt(Lt(a, b), 1)
    ELSIF StrEqual(op, ">=") THEN WriteInt(Ge(a, b), 1)
    ELSIF StrEqual(op, "<=") THEN WriteInt(Le(a, b), 1)
    ELSE Usage END;

END FractionMath.

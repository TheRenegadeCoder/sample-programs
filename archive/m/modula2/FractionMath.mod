MODULE FractionMath;

(* Imports *)
FROM Terminal2 IMPORT WriteString, WriteLn, WriteInt;

(* Fraction Class *)
TRACED CLASS Fraction;
    REVEAL GreatestCommonDivisor, Reduce, SetFraction, ShowFraction; (* Making attributes and methods public*)
    VAR 
    numerator: INTEGER;
    denominator: INTEGER;
    gcd : INTEGER;

    PROCEDURE SetFraction(n, d : INTEGER);
    BEGIN
        numerator := n;
        denominator := d;
    END SetFraction;

    PROCEDURE GreatestCommonDivisor(n, d : INTEGER) : INTEGER;
    BEGIN
        IF d = 0 THEN
            WriteString("error cannot divide by 0");
        END;

        WHILE n # d DO 
            IF n > d THEN 
                n := n - d;
            ELSE
                d := d - n;
            END;
        END;
    
        RETURN n;
    END;

    PROCEDURE Reduce(n, d : INTEGER);
    BEGIN 
        IF d = 0 THEN
            WriteString("error cannot divide by 0");
        
        ELSE
            gcd := GreatestCommonDenominator(n, d);
            numerator := n / gcd;
            denominator := d / gcd;
        END;
    END; 
    
    PROCEDURE ShowFraction(f : Fraction);
    BEGIN
        WriteInt(numerator);
        WriteString("/");
        WriteInt(denominator);
        WriteLn;
    END;


(* Proceedures Operators*)
OPERATOR = (f1, f2 : Fraction) : BOOL 
BEGIN
    IF  THEN
        WriteString("0");
        WriteLn;

    ELSE
        WriteString("1 error");
        WriteLn;
    END;
END;

PROCEDURE [#] notEqual(f1, f2 : Fraction) : BOOL 
(* BEGIN    
    IF fOne # fTwo THEN
        WriteString("1");
        WriteLn;

    ELSE
        WriteString("0 error");
        WriteLn;
    END;
END; *)

PROCEDURE [>] GreaterThan(f1, f2 : Fraction) : BOOL 
BEGIN
    IF fOne > fracTwo THEN
        WriteString("0");
        WriteLn;
    ELSE
        WriteString("1 error");
        WriteLn;
    END;
END; 

PROCEDURE [<] LessThan(f1, f2 : Fraction) : BOOL 
(* BEGIN
    IF fOne < fracTwo THEN
        WriteString("0");
        WriteLn;
    ELSE
        WriteString("1 error");
        WriteLn;
    END;
END; *)

PROCEDURE [>=] GreaterThanEquals(f1, f2 : Fraction) : BOOL 
(* BEGIN
    IF fOne >= fracTwo THEN
        WriteString("0");
        WriteLn;
    ELSE
        WriteString("1 error");
        WriteLn;
    END;
END; *)

PROCEDURE [<=] LessThanEquals(f1, f2 : Fraction) : BOOL 
(* BEGIN
    IF fOne <= fracTwo THEN
        WriteString("0");
        WriteLn;
    ELSE
        WriteString("1 error");
        WriteLn;
    END;
END; *)
VAR fResult : Fraction;
PROCEDURE [+] Addition(f1, f2 : Fraction) : Fraction
BEGIN
    CREATE(fResult);
    IF f1.denominator = f2.denominator THEN
        fResult.SetFraction(f1.numerator + f2.numerator, f1.denominator);        
    ELSE
        fResult.SetFraction((f1.numerator * f2.denominator) + (f2.numerator * f1.denominator), f1.denominator * f2.denominator);
        gcd = GreatestCommonDivisor(fResult.numerator, fResult.denominator);
        fResult.SetFraction(fResult.numerator / gcd, fResult.denominator / gcd);
    END;
END;

PROCEDURE [-] Subtraction(f1, f2 : Fraction) : Fraction
BEGIN
    CREATE(fResult);
    IF f1.denominator = f2.denominator THEN
        fResult.SetFraction(f1.numerator - f2.numerator, f1.denominator);        
    ELSE
        fResult.SetFraction((f1.numerator * f2.denominator) - (f2.numerator * f1.denominator), f1.denominator * f2.denominator);
        gcd = GreatestCommonDivisor(fResult.numerator, fResult.denominator);
        fResult.SetFraction(fResult.numerator / gcd, fResult.denominator / gcd);
    END;
END;

PROCEDURE [*] Multiplication(f1, f2 : Fraction) :Fraction
BEGIN
    CREATE(fResult);
    fResult.SetFraction(f1.numerator * f2.numerator, f1.denominator * f2.denominator);
    gcd = GreatestCommonDivisor(fResult.numerator, fResult.denominator);
    fResult.SetFraction(fResult.numerator / gcd, fResult.denominator / gcd);
END;

PROCEDURE [/] Division(f1, f2 : Fraction) : Fraction
BEGIN
    CREATE(fResult);
    fResult.SetFraction(f1.numerator * f2.denominator, f1.denominator * f1.numerator);
    gcd = GreatestCommonDivisor(fResult.numerator, fResult.denominator);
    fResult.SetFraction(fResult.numerator / gcd, fResult.denominator / gcd);
END;

(* Vars and methods for main method *)
VAR fracOne : Fraction;
    fracTwo : Fraction;
    
    
PROCEDURE result(f1 : INTEGER, op : STRING, f2 : INTEGER) : Fraction
BEGIN
    IF op = "+" THEN 
        RETURN f1 + f2;
    ELSE IF op = "-" THEN 
        RETURN f1 - f2;
    ELSE IF op = "*" THEN 
        RETURN f1 * f2;
    ELSE IF op = "/" THEN 
        RETURN f1 / f2;
    ELSE IF op = ">" THEN 
        RETURN f1 > f2
    ELSE IF op = ">=" THEN 
        RETURN f1 >= f2
    ELSE IF op = "<" THEN 
        RETURN f1 < f2
    ELSE IF op = "<=" THEN 
        RETURN f1 <= f2
    ELSE IF op = "=" THEN 
        RETURN f1 = f2
    ELSE IF op = "#" THEN 
        RETURN f1 # f2
    ELSE
        RETURN WriteString("Invalid operator");
    END;    
END;

(* Main Method *)
BEGIN 
    CREATE(fracOne);
    CREATE(fracTwo);
    IF fracOne # EMPTY AND fracTwo # EMPTY THEN
        fracOne.SetFraction(2, 3);
        fracTwo.SetFraction(4, 5);

        ShowFraction(result(fracOne, "+", fracTwo));
        ShowFraction(result(fracOne, "-", fracTwo));        
        ShowFraction(result(fracOne, "*", fracTwo));        
        ShowFraction(result(fracOne, "/", fracTwo));        
        ShowFraction(result(fracOne, ">", fracTwo));        
        ShowFraction(result(fracOne, "<", fracTwo));        
        ShowFraction(result(fracOne, ">=", fracTwo));       
        ShowFraction(result(fracOne, "<=", fracTwo));        
        ShowFraction(result(fracOne, "#", fracTwo));        
        ShowFraction(result(fracOne, "=", fracTwo));
        
    ELSE
        WriteString("Error");
    END;

END FractionMath.
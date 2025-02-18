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
VAR fResult : Fraction;

PROCEDURE [=] isEqual(f1, f2 : Fraction) : BOOL 
BEGIN
    IF (f1.numerator * f2.denominator) = (f1.denominator * f2.numerator) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END;
END;

PROCEDURE [#] notEqual(f1, f2 : Fraction) : BOOL 
BEGIN 
    RETURN f1 = f2;
    (* IF (f1.numerator * f2.denominator) # (f2.numerator * f2.denominator) THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END; *)
END;

PROCEDURE [>] isGreater(f1, f2 : Fraction) : BOOL 
BEGIN
    IF (f1.numerator * f2.denominator) > (f1.denominator * f2.numerator) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END;
END; 

PROCEDURE [<] isLess(f1, f2 : Fraction) : BOOL 
BEGIN
    IF (f1.numerator * f2.denominator) < (f1.denominator * f2.numerator) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END;
END;

PROCEDURE [>=] greaterOrEqual(f1, f2 : Fraction) : BOOL 
BEGIN
    IF (f1.numerator * f2.denominator) >= (f1.denominator * f2.numerator) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END;
END;

PROCEDURE [<=] lessOrEqual(f1, f2 : Fraction) : BOOL 
BEGIN
    IF (f1.numerator * f2.denominator) <= (f1.denominator * f2.numerator) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END;
END;

PROCEDURE [+] Add(f1, f2 : Fraction) : Fraction
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

PROCEDURE [-] Sub(f1, f2 : Fraction) : Fraction
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

PROCEDURE [*] Mult(f1, f2 : Fraction) :Fraction
BEGIN
    CREATE(fResult);
    fResult.SetFraction(f1.numerator * f2.numerator, f1.denominator * f2.denominator);
    gcd = GreatestCommonDivisor(fResult.numerator, fResult.denominator);
    fResult.SetFraction(fResult.numerator / gcd, fResult.denominator / gcd);
END;

PROCEDURE [/] Div(f1, f2 : Fraction) : Fraction
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
program FractionMath;

{$mode objfpc}{$H+}{$modeswitch advancedrecords}

uses
   Math,
   SysUtils;

type

   { TFraction }

   TFraction = record
      Numerator, Denominator: int64;

      procedure Reduce;
      function ToString: string;
   class operator +(const A, B: TFraction): TFraction;
   class operator -(const A, B: TFraction): TFraction;
   class operator *(const A, B: TFraction): TFraction;
   class operator /(const A, B: TFraction): TFraction;
   class operator =(const A, B: TFraction): boolean;
   class operator <>(const A, B: TFraction): boolean;
   class operator <(const A, B: TFraction): boolean;
   class operator <=(const A, B: TFraction): boolean;
   class operator >(const A, B: TFraction): boolean;
   class operator >=(const A, B: TFraction): boolean;
   end;

procedure TFraction.Reduce; inline;
var
   Divisor, GcdA, GcdB, Temp: int64;
begin
   if Denominator = 0 then
      raise Exception.Create('Denominator cannot be zero');

   if Numerator = 0 then
   begin
      Denominator := 1;
      Exit;
   end;

   if Denominator < 0 then
   begin
      Denominator := -Denominator;
      Numerator := -Numerator;
   end;

   GcdA := Abs(Numerator);
   GcdB := Denominator;

   while GcdB <> 0 do
   begin
      Temp := GcdB;
      GcdB := GcdA mod GcdB;
      GcdA := Temp;
   end;

   Divisor := GcdA;

   // If the GCD is not 1, then simplify the top and the bottom.
   if Divisor > 1 then
   begin
      Numerator := Numerator div Divisor;
      Denominator := Denominator div Divisor;
   end;
end;

function TFraction.ToString: string;
begin
   Result := Format('%d/%d', [Numerator, Denominator]);
end;

class operator TFraction.+(const A, B: TFraction): TFraction;
begin
   Result.Numerator := A.Numerator * B.Denominator + B.Numerator * A.Denominator;
   Result.Denominator := A.Denominator * B.Denominator;
   Result.Reduce;
end;

class operator TFraction.-(const A, B: TFraction): TFraction;
begin
   Result.Numerator := A.Numerator * B.Denominator - B.Numerator * A.Denominator;
   Result.Denominator := A.Denominator * B.Denominator;
   Result.Reduce;
end;

class operator TFraction.*(const A, B: TFraction): TFraction;
begin
   Result.Numerator := A.Numerator * B.Numerator;
   Result.Denominator := A.Denominator * B.Denominator;
   Result.Reduce;
end;

class operator TFraction./(const A, B: TFraction): TFraction;
begin
   if B.Numerator = 0 then
      raise Exception.Create('Division by zero fraction');

   Result.Numerator := A.Numerator * B.Denominator;
   Result.Denominator := A.Denominator * B.Numerator;
   Result.Reduce;
end;

class operator TFraction.=(const A, B: TFraction): boolean;
begin
   Result := A.Numerator * B.Denominator = B.Numerator * A.Denominator;
end;

class operator TFraction.<>(const A, B: TFraction): boolean;
begin
   Result := not (A = B);
end;

class operator TFraction.<(const A, B: TFraction): boolean;
begin
   Result := A.Numerator * B.Denominator < B.Numerator * A.Denominator;
end;

class operator TFraction.>=(const A, B: TFraction): boolean;
begin
   Result := not (A < B);
end;

class operator TFraction.>(const A, B: TFraction): boolean;
begin
   Result := B < A;
end;

class operator TFraction.<=(const A, B: TFraction): boolean;
begin
   Result := not (B < A);
end;

function ParseFraction(const S: string): TFraction;
var
   Parts: TStringArray;
begin
   Parts := S.Trim.Split(['/']);
   if Length(Parts) <> 2 then
      raise Exception.CreateFmt('Invalid fraction format "%s". Expected "num/den"', [S]);

   if not TryStrToInt64(Parts[0].Trim, Result.Numerator) then
      raise Exception.Create('Invalid numerator');

   if not TryStrToInt64(Parts[1].Trim, Result.Denominator) then
      raise Exception.Create('Invalid denominator');

   if Result.Denominator = 0 then
      raise Exception.Create('Denominator cannot be zero');

   Result.Reduce;
end;

procedure ShowUsage;
begin
   Writeln('Usage: ./fraction-math operand1 operator operand2');
   Halt(1);
end;

function PerformOperation(const Left: TFraction; const Op: string;
const Right: TFraction): string;
begin
   case Op of
      '+': Result := (Left + Right).ToString;
      '-': Result := (Left - Right).ToString;
      '*': Result := (Left * Right).ToString;
      '/': Result := (Left / Right).ToString;
      '==': Result := BoolToStr(Left = Right, '1', '0');
      '!=': Result := BoolToStr(Left <> Right, '1', '0');
      '<': Result := BoolToStr(Left < Right, '1', '0');
      '<=': Result := BoolToStr(Left <= Right, '1', '0');
      '>': Result := BoolToStr(Left > Right, '1', '0');
      '>=': Result := BoolToStr(Left >= Right, '1', '0');
      else
         raise Exception.CreateFmt('Unknown operator: "%s"', [Op]);
   end;
end;


var
   Op: string;
   LeftOperand, RightOperand: TFraction;
begin
   if ParamCount <> 3 then
      ShowUsage;

   try
      LeftOperand := ParseFraction(ParamStr(1));
      Op := ParamStr(2).Trim;
      RightOperand := ParseFraction(ParamStr(3));

      Writeln(PerformOperation(LeftOperand, &Op, RightOperand));
   except
      on E: Exception do
         ShowUsage;
   end;

end.

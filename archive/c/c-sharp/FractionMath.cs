using System.Numerics;

if (
    args is not [var leftRaw, var op, var rightRaw]
    || !Fraction.TryParse(leftRaw, out var a)
    || !Fraction.TryParse(rightRaw, out var b)
)
{
    Console.WriteLine("Usage: ./fraction-math operand1 operator operand2");
    return;
}

string result = op switch
{
    "+" => (a + b).ToString(),
    "-" => (a - b).ToString(),
    "*" => (a * b).ToString(),
    "/" => (a / b).ToString(),
    "==" => a == b ? "1" : "0",
    "!=" => a != b ? "1" : "0",
    ">" => a > b ? "1" : "0",
    "<" => a < b ? "1" : "0",
    ">=" => a >= b ? "1" : "0",
    "<=" => a <= b ? "1" : "0",
    _ => "Error: Invalid operator",
};

Console.WriteLine(result);

public readonly struct Fraction : IEquatable<Fraction>, IComparable<Fraction>
{
    public long Numerator { get; }
    public long Denominator { get; }

    private Fraction(long n, long d)
    {
        Numerator = n;
        Denominator = d;
    }

    public static Fraction Create(long n, long d)
    {
        if (d == 0)
            throw new DivideByZeroException();

        long g = Gcd(n, d);
        n /= g;
        d /= g;

        int sign = Math.Sign(d);

        return new(n * sign, Math.Abs(d));
    }

    public override string ToString() => $"{Numerator}/{Denominator}";

    private static long Gcd(long a, long b)
    {
        a = Math.Abs(a);
        b = Math.Abs(b);

        while (b != 0)
            (a, b) = (b, a % b);

        return a == 0 ? 1 : a;
    }

    public static bool TryParse(ReadOnlySpan<char> s, out Fraction value)
    {
        value = default;

        int slash = s.IndexOf('/');
        if (slash < 0)
            return false;

        if (!long.TryParse(s[..slash], out long n) || !long.TryParse(s[(slash + 1)..], out long d))
            return false;

        if (d == 0)
            return false;

        value = Create(n, d);
        return true;
    }

    public static Fraction operator +(Fraction a, Fraction b) =>
        Create(
            a.Numerator * b.Denominator + b.Numerator * a.Denominator,
            a.Denominator * b.Denominator
        );

    public static Fraction operator -(Fraction a, Fraction b) =>
        Create(
            a.Numerator * b.Denominator - b.Numerator * a.Denominator,
            a.Denominator * b.Denominator
        );

    public static Fraction operator *(Fraction a, Fraction b)
    {
        long aNum = a.Numerator;
        long aDen = a.Denominator;
        long bNum = b.Numerator;
        long bDen = b.Denominator;

        // Cancel cross factors before multiplying to prevent overflow
        long g1 = Gcd(aNum, bDen);
        aNum /= g1;
        bDen /= g1;

        long g2 = Gcd(bNum, aDen);
        bNum /= g2;
        aDen /= g2;

        return Create(aNum * bNum, aDen * bDen);
    }

    public static Fraction operator /(Fraction a, Fraction b)
    {
        if (b.Numerator == 0)
            throw new DivideByZeroException();

        long aNum = a.Numerator;
        long aDen = a.Denominator;
        long bNum = b.Numerator;
        long bDen = b.Denominator;

        // Cancel cross factors before multiplying to prevent overflow
        long g1 = Gcd(aNum, bNum);
        aNum /= g1;
        bNum /= g1;

        long g2 = Gcd(bDen, aDen);
        bDen /= g2;
        aDen /= g2;

        return Create(aNum * bDen, aDen * bNum);
    }

    public static bool operator ==(Fraction a, Fraction b) =>
        a.Numerator == b.Numerator && a.Denominator == b.Denominator;

    public static bool operator !=(Fraction a, Fraction b) => !(a == b);

    public static bool operator <(Fraction a, Fraction b) =>
        a.Numerator * b.Denominator < b.Numerator * a.Denominator;

    public static bool operator >(Fraction a, Fraction b) =>
        a.Numerator * b.Denominator > b.Numerator * a.Denominator;

    public static bool operator <=(Fraction a, Fraction b) => !(a > b);

    public static bool operator >=(Fraction a, Fraction b) => !(a < b);

    public bool Equals(Fraction other) => this == other;

    public int CompareTo(Fraction other)
    {
        long left = Numerator * other.Denominator;
        long right = other.Numerator * Denominator;
        return left.CompareTo(right);
    }

    public override bool Equals(object? obj) => obj is Fraction f && Equals(f);

    public override int GetHashCode() => HashCode.Combine(Numerator, Denominator);
}

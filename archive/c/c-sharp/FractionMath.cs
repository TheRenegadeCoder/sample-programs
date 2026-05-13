if (
    args is not [var leftRaw, var op, var rightRaw]
    || !Fraction.TryParse(leftRaw, out var a)
    || !Fraction.TryParse(rightRaw, out var b)
)
{
    Console.Error.WriteLine("Usage: ./fraction-math operand1 operator operand2");
    return;
}

Console.WriteLine(
    op switch
    {
        "+" => (a + b).ToString(),
        "-" => (a - b).ToString(),
        "*" => (a * b).ToString(),
        "/" => (a / b).ToString(),
        "==" => (a == b ? 1 : 0),
        "!=" => (a != b ? 1 : 0),
        ">" => (a > b ? 1 : 0),
        "<" => (a < b ? 1 : 0),
        ">=" => (a >= b ? 1 : 0),
        "<=" => (a <= b ? 1 : 0),
        _ => "Error: Invalid operator",
    }
);

public readonly record struct Fraction(long N, long D) : IComparable<Fraction>
{
    public override string ToString() => $"{N}/{D}";

    public static Fraction Create(long n, long d)
    {
        if (d == 0)
            throw new DivideByZeroException();

        long g = Gcd(n, d);
        return new(n / g * Math.Sign(d), Math.Abs(d / g));
    }

    static long Gcd(long a, long b)
    {
        a = Math.Abs(a);
        b = Math.Abs(b);

        while (b != 0)
            (a, b) = (b, a % b);

        return a == 0 ? 1 : a;
    }

    public static bool TryParse(ReadOnlySpan<char> s, out Fraction f)
    {
        f = default;

        int i = s.IndexOf('/');
        return i >= 0
            && long.TryParse(s[..i], out long n)
            && long.TryParse(s[(i + 1)..], out long d)
            && d != 0
            && (f = Create(n, d)) == f;
    }

    public static Fraction operator +(Fraction a, Fraction b) =>
        Create(a.N * b.D + b.N * a.D, a.D * b.D);

    public static Fraction operator -(Fraction a, Fraction b) =>
        Create(a.N * b.D - b.N * a.D, a.D * b.D);

    public static Fraction operator *(Fraction a, Fraction b) => Create(a.N * b.N, a.D * b.D);

    public static Fraction operator /(Fraction a, Fraction b) => Create(a.N * b.D, a.D * b.N);

    public static bool operator <(Fraction a, Fraction b) => a.N * b.D < b.N * a.D;

    public static bool operator >=(Fraction a, Fraction b) => !(a < b);

    public static bool operator >(Fraction a, Fraction b) => b < a;

    public static bool operator <=(Fraction a, Fraction b) => !(b < a);

    public int CompareTo(Fraction other) => (N * other.D).CompareTo(other.N * D);
}

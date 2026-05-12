using System.Collections.Generic;
using System.Runtime.InteropServices;

if (
    args is not [var xInput, var yInput]
    || !TryParsePoints(xInput.AsSpan(), yInput.AsSpan(), out var points)
)
{
    return ExitWithUsage();
}

points.Sort();
var hull = BuildHull(CollectionsMarshal.AsSpan(points));

foreach (var p in hull)
    Console.WriteLine(p);

return 0;

static bool TryParsePoints(
    ReadOnlySpan<char> xView,
    ReadOnlySpan<char> yView,
    out List<Point> points
)
{
    if (xView.IsWhiteSpace() || yView.IsWhiteSpace())
    {
        points = null!;
        return false;
    }

    var list = new List<Point>();

    while (!xView.IsEmpty && !yView.IsEmpty)
    {
        if (!TryParseNext(ref xView, out int x) || !TryParseNext(ref yView, out int y))
        {
            points = null!;
            return false;
        }

        list.Add(new Point(x, y));
    }

    // fail if mismatch or too few points
    if (!xView.IsEmpty || !yView.IsEmpty || list.Count < 3)
    {
        points = null!;
        return false;
    }

    points = list;
    return true;

    static bool TryParseNext(ref ReadOnlySpan<char> view, out int value)
    {
        int comma = view.IndexOf(',');

        ReadOnlySpan<char> token;
        if (comma >= 0)
        {
            token = view[..comma];
            view = view[(comma + 1)..];
        }
        else
        {
            token = view;
            view = default;
        }

        return int.TryParse(token, out value);
    }
}

static List<Point> BuildHull(Span<Point> points)
{
    int n = points.Length;
    if (n < 3)
        return [.. points];

    var hull = new List<Point>(n * 2);

    for (int i = 0; i < n; i++)
    {
        var p = points[i];

        while (hull.Count >= 2)
        {
            int k = hull.Count - 1;
            if (Cross(hull[k - 1], hull[k], p) > 0)
                break;

            hull.RemoveAt(k);
        }

        hull.Add(p);
    }

    int lowerSize = hull.Count;

    for (int i = n - 2; i >= 0; i--)
    {
        var p = points[i];

        while (hull.Count > lowerSize)
        {
            int k = hull.Count - 1;
            if (Cross(hull[k - 1], hull[k], p) > 0)
                break;

            hull.RemoveAt(k);
        }

        hull.Add(p);
    }

    hull.RemoveAt(hull.Count - 1);
    return hull;

    static long Cross(Point o, Point a, Point b) =>
        (long)(a.X - o.X) * (b.Y - o.Y) - (long)(a.Y - o.Y) * (b.X - o.X);
}

static int ExitWithUsage()
{
    Console.Error.WriteLine(
        """Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")"""
    );
    return 1;
}

public readonly record struct Point(int X, int Y) : IComparable<Point>
{
    public int CompareTo(Point other) => X != other.X ? X.CompareTo(other.X) : Y.CompareTo(other.Y);

    public override string ToString() => $"({X}, {Y})";
}

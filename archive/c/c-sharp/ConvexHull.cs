using System.Collections.Generic;
using System.Runtime.InteropServices;

if (args is not [var xInput, var yInput])
    return ExitWithUsage();

if (!TryParsePoints(xInput.AsSpan(), yInput.AsSpan(), out var points))
    return ExitWithUsage();

var hull = BuildHull(CollectionsMarshal.AsSpan(points));

foreach (var p in hull)
    Console.WriteLine(p);

return 0;

static bool TryParsePoints(
    ReadOnlySpan<char> xView,
    ReadOnlySpan<char> yView,
    out List<Point> destination
)
{
    destination = [];

    while (!xView.IsEmpty || !yView.IsEmpty)
    {
        if (!TryParseNextToken(ref xView, out int x) || !TryParseNextToken(ref yView, out int y))
            return false;

        destination.Add(new Point(x, y));

        // If one string ended before the other, the lists are mismatched
        if (xView.IsEmpty != yView.IsEmpty)
            return false;
    }
    return destination.Count >= 3;

    static bool TryParseNextToken(ref ReadOnlySpan<char> view, out int value)
    {
        int comma = view.IndexOf(',');
        ReadOnlySpan<char> segment = comma == -1 ? view : view[..comma];

        if (!int.TryParse(segment.Trim(), out value))
            return false;

        // Advance the span: if no more commas, we're done (set to Empty)
        view = comma == -1 ? default : view[(comma + 1)..];
        return true;
    }
}

static long Cross(Point o, Point a, Point b) =>
    (long)(a.X - o.X) * (b.Y - o.Y) - (long)(a.Y - o.Y) * (b.X - o.X);

static List<Point> BuildHull(Span<Point> points)
{
    int n = points.Length;
    if (n < 3)
        return [.. points];

    points.Sort();

    List<Point> hull = new(n);

    foreach (var p in points)
    {
        while (hull is [.., var p2, var p1] && Cross(p2, p1, p) <= 0)
            hull.RemoveAt(hull.Count - 1);

        hull.Add(p);
    }

    int lowerHullLimit = hull.Count;
    for (int i = n - 2; i >= 0; i--)
    {
        var p = points[i];
        while (hull.Count > lowerHullLimit && hull is [.., var p2, var p1] && Cross(p2, p1, p) <= 0)
            hull.RemoveAt(hull.Count - 1);

        hull.Add(p);
    }

    if (hull.Count > 1)
        hull.RemoveAt(hull.Count - 1);

    return hull;
}

static int ExitWithUsage()
{
    Console.Error.WriteLine(
        "Usage: please provide at least 3 x and y coordinates as separate lists (e.g. \"100, 440, 210\")"
    );
    return 1;
}

public readonly record struct Point(int X, int Y) : IComparable<Point>
{
    public int CompareTo(Point other) => X != other.X ? X.CompareTo(other.X) : Y.CompareTo(other.Y);

    public override string ToString() => $"({X}, {Y})";
}

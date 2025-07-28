using System;
using System.Collections.Generic;
using System.Linq;

public record Point(int X, int Y) : IComparable<Point>
{
    public int CompareTo(Point? other)
         => other is null ? 1 : X != other.X ? X.CompareTo(other.X) : Y.CompareTo(other.Y);

    public override string ToString() => $"({X}, {Y})";

    public static bool operator <(Point left, Point right) => left.CompareTo(right) < 0;
    public static bool operator >(Point left, Point right) => left.CompareTo(right) > 0;
}

public static class ConvexHull
{
    private static void ShowUsage()
    {
        Console.Error.WriteLine("Usage: please provide at least 3 x and y coordinates as separate lists (e.g. \"100, 440, 210\")");
    }

    private static List<int> ParseIntegerList(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
        {
            ShowUsage();
            Environment.Exit(1);
        }

        var list = input
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Select(part => int.TryParse(part, out var val)
                ? val
                : throw new ArgumentException($"Invalid integer value: '{part}'"))
            .ToList();

        if (list.Count < 3)
        {
            ShowUsage();
            Environment.Exit(1);
        }

        return list;
    }


    /// <summary>
    /// Calculates the cross product of vectors OA and OB.
    /// Positive result means counter-clockwise turn.
    /// Negative result means clockwise turn.
    /// Zero means points are colinear.
    /// </summary>
    private static long Cross(Point o, Point a, Point b)
    {
        var (ox, oy) = (o.X, o.Y);
        var (ax, ay) = (a.X, a.Y);
        var (bx, by) = (b.X, b.Y);
        return (long)(ax - ox) * (by - oy) - (long)(ay - oy) * (bx - ox);
    }


    /// <summary>
    /// Constructs the convex hull using the Jarvis March algorithm.
    /// </summary>
    private static List<Point> BuildHull(List<Point> points)
    {
        int n = points.Count;
        if (n < 3) return [.. points];

        int startIndex = 0;
        for (int i = 1; i < n; i++)
        {
            if (points[i] < points[startIndex])
                startIndex = i;
        }

        var hull = new List<Point>();
        int currentIndex = startIndex;

        do
        {
            hull.Add(points[currentIndex]);
            int candidateIndex = (currentIndex + 1) % n;

            for (int i = 0; i < n; i++)
            {
                if (Cross(points[currentIndex], points[i], points[candidateIndex]) > 0)
                    candidateIndex = i;
            }

            currentIndex = candidateIndex;

        } while (currentIndex != startIndex);

        return hull;
    }

    public static int Main(string[] args)
    {
        if (args.Length != 2)
        {
            ShowUsage();
            return 1;
        }

        try
        {
            var xCoords = ParseIntegerList(args[0]);
            var yCoords = ParseIntegerList(args[1]);
            if (xCoords.Count != yCoords.Count)
            {
                ShowUsage();
                return 1;
            }

            if (xCoords.Count < 3)
            {
                ShowUsage();
                return 1;
            }

            var points = xCoords.Zip(yCoords, (x, y) => new Point(x, y)).ToList();

            BuildHull(points).ForEach(Console.WriteLine);

            return 0;
        }
        catch
        {
            ShowUsage();
            return 1;
        }
    }
}

using System;
using System.Collections;

namespace ConvexHull;

struct Point<T>
{
    public T x;
    public T y;

    public this(T xValue, T yValue)
    {
        x = xValue;
        y = yValue;
    }

    public override void ToString(String str)
    {
        str.AppendF("({}, {})", x, y);
    }
}

class PointsList<T> : List<Point<T>>
{
    public this()
    {
    }

    public this(List<T> xValues, List<T> yValues)
    {
        for (int i < xValues.Count)
        {
            this.Add(.(xValues[i], yValues[i]));
        }
    }

    public override void ToString(String str)
    {
        for (Point<T> point in this)
        {
            str.AppendF("{}\n", point);
        }
    }
}

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            """
            Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")
            """
        );
        Environment.Exit(0);
    }

    public static Result<T> ParseInt<T>(StringView str)
    where T : IParseable<T>
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // T.Parse ignores single quotes since they are treat as digit separators -- e.g. 1'000
        if (trimmedStr.Contains('\''))
        {
            return .Err;
        }

        return T.Parse(trimmedStr);
    }

    public static Result<void> ParseIntList<T>(StringView str, List<T> arr)
    where T: IParseable<T>
    {
        arr.Clear();
        for (StringView item in str.Split(','))
        {
            switch (ParseInt<T>(item))
            {
                case .Ok(let val):
                    arr.Add(val);

                case .Err:
                    return .Err;
            }
        }

        return .Ok;
    }

    // Find Convex Hull using Jarvis' algorithm
    // Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
    public static void ConvexHull<T>(PointsList<T> points, PointsList<T> hullPoints)
    where T : operator T - T, operator T * T
    where int : operator T <=> T
    {
        int n = points.Count;

        // Initialize hull points
        hullPoints.Clear();

        // The first point is the leftmost point with the highest y-coord in the
        // event of a tie
        int l = 0;
        for (int i in 1..<n)
        {
            if (points[i].x < points[l].x ||
                (points[i].x == points[l].x && points[i].y > points[i].y))
            {
                l = i;
            }
        }

        // Repeat until wrapped around to first hull point
        int p = l;
        repeat
        {
            // Store convex hull point
            hullPoints.Add(points[p]);

            int q = (p + 1) % n;
            for (int j < n)
            {
                // If point j is more counter-clockwise, then update end point (q)
                if (Orientation<T>(points[p], points[j], points[q]) < 0)
                {
                    q = j;
                }
            }

            p = q;
        }
        while (p != l);
    }

    // Get orientation of three points
    //
    // 0 = points are in a line
    // > 0 = points are clockwise
    // < 0 = points are counter-clockwise
    public static int Orientation<T>(Point<T> p, Point<T> q, Point<T> r)
    where T : operator T - T, operator T * T
    where int : operator T <=> T
    {
        return (q.y - p.y) * (r.x - q.x) <=> (q.x - p.x) * (r.y - q.y);
    }

    public static int Main(String[] args)
    {
        if (args.Count < 2)
        {
            Usage();
        }

        List<int32> xValues = scope .();
        if (ParseIntList<int32>(args[0], xValues) case .Err)
        {
            Usage();
        }

        List<int32> yValues = scope .();
        if (ParseIntList<int32>(args[1], yValues) case .Err)
        {
            Usage();
        }

        if (xValues.Count != yValues.Count || xValues.Count < 3)
        {
            Usage();
        }

        PointsList<int32> points = scope .(xValues, yValues);
        PointsList<int32> hullPoints = scope .();
        ConvexHull(points, hullPoints);
        Console.WriteLine(hullPoints);

        return 0;
    }
}

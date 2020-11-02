using System;
using System.Collections.Generic;
using System.Linq;

public class ConvexHull
{
	class Point
	{
		public int X { get; set; }
		public int Y { get; set; }
	}

    public static void ErrorAndExit()
    {
        Console.WriteLine("Usage: please provide at least 3 x and y coordinates as separate lists (e.g. \"100, 440, 210\")");
        Environment.Exit(1);
    }
	
	public static void Main(string[] args)
	{
		bool inError = false;

		string[] xs = args[0].Replace("\"", string.Empty).Split(',');
		string[] ys = args[1].Replace("\"", string.Empty).Split(',');

		error |= (xs.Length != ys.Length);
		error |= (xs.Length < 3);

		// Checking data
		Point[] points = new Point[xs.Length];
		for (int i = 0; i < points.Length && !error; i++)
		{
			int x = 0, y = 0;

			error |= !(int.TryParse(xs[i], out x));
			error |= !(int.TryParse(ys[i], out y));

			points[i] = new Point { X = x, Y = y };
		}

		if (error)
			ErrorAndExit();
		
		List<Point> convexHull = new List<Point>();

		// Algorithm start (Jarvis' Algorithm)
		int minX = points.Min(pt => pt.X);
		Point leftmost = points.First(pt => pt.X == minX); // I don't care if there are more than one

		convexHull.Add(leftmost);

		// Jarvis' Algorithm states that to determine the next point in the convex hull you need 
		// to find the rightmost point, compared to the last one identified.
		// i.e. given P the last point and Q the one in exam, there is no point R in the remaining
		// set that creates a clockwise triangle PQR
		Point p = leftmost;
		Point nextInHull = null;
		while (true)
		{
			nextInHull = null;
			foreach (Point q in points)
			{
				if (q == p)
					continue;

				// if I find at least one point clockwise, then it's not the rightmost one
				if (points.Any(r =>
				{
					if (r == q || r == p)
						return false;
					return IsClockwise(p, q, r);
				}))
					continue;

				nextInHull = q;
				break; // I found the right one, just stop here
			}

			if (nextInHull != leftmost)
			{
				convexHull.Add(nextInHull);
				p = nextInHull;
			}
			else 
				break;
		}

		Console.WriteLine("Convex Hull:");
		foreach (Point pt in convexHull)
			Console.WriteLine("({0}, {1})", pt.X, pt.Y);

		Console.ReadKey();
	}

	private static bool IsClockwise(Point p, Point q, Point r)
	{
		return ((q.Y - p.Y) * (r.X - q.X) - (r.Y - q.Y) * (q.X - p.X)) > 0;
	}
}

import java.util.*;
public class ConvexHull
{
   public static void main(String[] args)
   {
      if(args.length<2)
         System.out.println("Usage: please provide two strings of x-coordinates and y-coordinates");
      else {
         String xInput = args[0];
         String yInput = args[1];
         String[] tempX = xInput.split(", ");
         String[] tempY = yInput.split(", ");
         if(tempX.length!=tempY.length) {
            System.out.println("Error: please provide two equal length sets of x-coordinates and y-coordinates");
            return;
         }
         Point[] points = new Point[tempX.length];
         double minX = Double.MAX_VALUE;
         int mindex = 0;
         for(int a=0; a<tempX.length; a++) {
            points[a] = new Point(Double.parseDouble(tempX[a]),Double.parseDouble(tempY[a]));
            if(points[a].x<=minX) {
               minX = points[a].x;
               mindex = a;
            }
         }
         Stack<Point> result = new Stack<Point>();
         int considerdex = mindex;
         do {
            result.push(points[considerdex]);
            int nextdex = (considerdex+1)%points.length;
            for(int contenderdex=0; contenderdex<points.length; contenderdex++) {
               if(isCounterClockwise(points[considerdex],points[nextdex],points[contenderdex]))
                  nextdex = contenderdex;
            }
            considerdex=nextdex;
         } while(considerdex!=mindex);
         int k = result.size();
         for(int a=0; a<k; a++) {
            System.out.println(result.pop().toString());
         }
      }
   }
   public static boolean isCounterClockwise(Point a, Point b, Point c)
   {
      return (c.y-a.y)*(b.x-a.x)>(b.y-a.y)*(c.x-a.x);
   }
}
class Point
{
   public double x;
   public double y;
   public Point(double a,double b)
   {
      x=a;
      y=b;
   }
   public String toString()
   {
      return "("+x+", "+y+")";
   }
}
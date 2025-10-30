// Starting out changes, base template courtesy of w3Schools
#include <iostream>
#include <vector>
using namespace std;

class Point {
  public:
    int x;
    int y;
    Point(int horizontal, int vertical) {
      x = horizontal;
      y = vertical;
    }
};

// Expected input, array of arrays, which will be turned into points

Point point1(1, 4);
Point point2(0, 1);
Point point3(5, 7);
Point point4(2, 10);
Point point5(8, 3);
Point point6(12, 15);
Point point7(9, 6);
Point point8(1, 1);
Point point9(10, 20);
Point point10(3, 5);

// Temporary data
Point points[10] = {point1, point2, point3, point4, point5, point6, point7, point8, point9, point10};

void plannedTransformer() {
  // Checks if current shape needs another point 
  // (If any points are outside the current leftmost boundary, then make a new point along the farthest outward one)
  // (^ Above explanation just needs to swap x,y values to negatives, or trade places, to fit all directions)

  // Requirement | If you have two matching values for farthese/lowest/highest take the first value you see 
  // Step 1 - Note down seperate points that are: The farthest left, the farthest right, the lowest, the highest
  // Step 2 - Draw the lines between current points in pencil that make a shape
  // Step 3 - Erase lines where on its outer side, there is a point, write down the paired points of such lines
  // For each noted line ->
  // Step 4 - Re-pair the written down points with the new point in the middle
  // (Below should be a method)
  // Step 5 - For newly made lines, repeat step 3
  // Step 6 - If there is another detection by step 5, do step 4 with them
  // Input: {2, 5}, {-1, 5}, {0, 0}, {-8, 3}, {7, 4}, {-3, -4}, {4, -2}
  // Output: {2, 5}, {-1, 5}, {-8, 3}, {7, 4}, {-3, -4}, {4, -2}
}

int crossProductLine(Point point1, Point point2, Point checkedPoint);

// Step 1
int startSolve(){
  Point kingNumVert = points[0];
  Point kingNumHor = points[0];
  Point lowNumVert = points[0];
  Point lowNumHor = points[0];

  for (Point point : points) {
    if (kingNumHor.x < point.x) {
      kingNumHor = point;
    }
    else if (lowNumHor.x > point.x) {
      lowNumHor = point;
    }
    if (kingNumVert.y < point.y) {
      kingNumVert = point;
    }
    else if (lowNumVert.y > point.y) {
      lowNumVert = point;
    }
  }
  // Step 2
  std::vector<Point> tempShape = {kingNumVert, kingNumHor, lowNumVert, lowNumHor};
  // Step 3 - looping variable to loop
  // All to the right? Go to the next one and repeat
  // I've been approaching this wrong, starting at an outlier point I need to look at every line to see which one doesn't have any elements to the right of it rotationally
  bool looping = true;
  while (looping == true) {
    looping = false;
    vector<Point> newShape;
    newShape = tempShape;
    for (int i = 0; i < tempShape.size(); i++) {
      // Iterating through each point
      Point firstPoint = tempShape[i];
      Point secondPoint = tempShape[(i + 1) % tempShape.size()];
      newShape.push_back(firstPoint);
      
      for (Point thirdPoint : points) {
        if (crossProductLine(firstPoint, secondPoint, thirdPoint) > 0) {
          newShape.push_back(thirdPoint);
          looping = true;
          if (!(newShape.back().x == thirdPoint.x && newShape.back().y == thirdPoint.y)) {
            newShape.push_back(thirdPoint);
            looping = true;
          }
        }
      }
    }
    cout << "Temp made to newShape\n";
    tempShape = newShape;
  }
  cout << "Convex hull points:\n";
  for (Point p : tempShape) {
    cout << "(" << p.x << "," << p.y << ")\n";
  }
  return 1;
}
int needToRestart = true;
// For each direction do cross product with an adjacent direction clockwise

int crossProductLine(Point point1, Point point2, Point checkedPoint) {
  int calc1 = point2.x - point1.x;
  int calc2 = checkedPoint.y - point1.y;
  int calc3 = point2.y - point1.y;
  int calc4 = checkedPoint.x - point1.x;

  int result = (calc1 * calc2) - (calc3 * calc4);
  
  if (result > 0) {
    // Left side
    return 1;
  } else if (result == 0) {
    // On the line
    return 0;
  } else {
    // Right side
    return -1;
  }
  
};

int main() {
  // Check if shape needs another point
  startSolve();
  
  return 0;
}
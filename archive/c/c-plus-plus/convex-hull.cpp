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

vector<Point> points;
// Expected input, array of arrays, which will be turned into points

// Point point1(1, 4);
// Point point2(0, 1);
// Point point3(5, 7);
// Point point4(2, 10);
// Point point5(8, 3);
// Point point6(12, 15);
// Point point7(9, 6);
// Point point8(1, 1);
// Point point9(10, 20);
// Point point10(3, 5);

// // Temporary data
// std::vector<Point> points = {point1, point2, point3, point4, point5, point6, point7, point8, point9, point10};

int crossProductLine(Point point1, Point point2, Point checkedPoint);

// Step 1
int startSolve(){
  Point kingNumVert = points[0];
  Point kingNumHor = points[0];
  Point lowNumVert = points[0];
  Point lowNumHor = points[0];
  int increment = 0;
  int permIncrement = 0;
  for (Point point : points) {
    if (kingNumHor.x < point.x) {
      kingNumHor = point;
    }
    else if (lowNumHor.x > point.x) {
      lowNumHor = point;
      permIncrement = increment;
    }
    if (kingNumVert.y < point.y) {
      kingNumVert = point;
    }
    else if (lowNumVert.y > point.y) {
      lowNumVert = point;
    }
    increment += 1;
  }
  // Step 2
  std::vector<Point> tempShape = {kingNumVert, kingNumHor, lowNumVert, lowNumHor};
  // Step 3 - looping variable to loop
  // All to the right? Go to the next one and repeat
  // I've been approaching this wrong, starting at an outlier point I need to look at every line to see which one doesn't have any elements to the right of it rotationally
  bool looping = true;
  int nextNumber = permIncrement;
  vector<Point> newShape;
  do {
    newShape.push_back(points[nextNumber]);
    int nextPointCandidate = (nextNumber + 1) % points.size();

    for (int i = 0; i < points.size(); i++) {
      if (crossProductLine(points[nextNumber], points[i], points[nextPointCandidate]) == 1) {
        nextPointCandidate = i; // point i is more counterclockwise
      }
    }

    nextNumber = nextPointCandidate;
  } while (nextNumber != permIncrement);
  cout << "Finished process";
  points = newShape;
  return 2;

  
}
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
  
}

/* 
  Input
  Takes parameter of an array of arrays, dictated as coordinates
  ex: { {2, 5}, {-1, 5}, {0, 0}, {-8, 3}, {7, 4}, {-3, -4}, {4, -2} }

  Output
  Returns coordinates of Convex Hull
  expected result: { {2, 5}, {-1, 5}, {-8, 3}, {7, 4}, {-3, -4}, {4, -2} }
*/

// Below code hasn't been verified for compatability with testing tools, as I could not find them
// If it does not work, verify integrity by uncommenting the sample data, lines 18-30
vector<Point> parsePoints(int argc, char* argv[]) {
    vector<Point> pts;
    for (int i = 1; i < argc; ++i) { // skip argv[0], program name
        string arg = argv[i];
        size_t commaPos = arg.find(',');
        if (commaPos == string::npos) continue; // invalid input
        int x = stoi(arg.substr(0, commaPos));
        int y = stoi(arg.substr(commaPos + 1));
        pts.push_back(Point(x, y));
    }
    return pts;
}

int main(int argc, char* argv[]) {
  // Check code integrity by also commenting out the two lines below this
  points = parsePoints(argc, argv);
  startSolve();
  cout << "Convex Hull Points (counterclockwise order):" << endl;
  for (Point pt : points) {
    cout << "(" << pt.x << ", " << pt.y << ")" << endl;
  }
  
  return 0;
}
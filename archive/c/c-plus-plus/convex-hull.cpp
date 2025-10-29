// Starting out changes, base template courtesy of w3Schools
#include <iostream>
#include <vector>
using namespace std;

class Point {
  public:
    int horizontal;
    int vertical;
    Point(int x, int y) {
      horizontal = x;
      vertical = y;
    }
};


Point point1(1, 4);
Point point2(0, 1);
Point point3(5, 7);
Point point4(2, 10);

std::vector<Point> points = {point1, point2, point3, point4};

void plannedTransformer() {
  // Checks if current shape needs another point 
  // (If any points are outside the current leftmost boundary, then make a new point along the farthest outward one)
  // (^ Above explanation just needs to swap x,y values to negatives, or trade places, to fit all directions)

  // Requirement | If you have two matching values for farthese/lowest/highest take the first value you see 
  // Step 1 - Note down seperate points that are: The farthest left, the farthest right, the lowest, the highest
  // Step 2 - Draw the lines between current points in pencil that make a shape
  // Step 3 - Erase lines where on its outer side, there is a point, write down the paired points of such lines
  // (If confused with above step, use the cross-product method)
  // For each noted line ->
  // Step 4 - Re-pair the written down points with the new point in the middle
  // (Below should be a method)
  // Step 5 - For newly made lines, repeat step 3
  // Step 6 - If there is another detection by step 5, do step 4 with them
  // Input: {2, 5}, {-1, 5}, {0, 0}, {-8, 3}, {7, 4}, {-3, -4}, {4, -2}
  // Output: {2, 5}, {-1, 5}, {-8, 3}, {7, 4}, {-3, -4}, {4, -2}
  std::cout << "Printing vector contents:" << std::endl;
  for (Point value : points) {
    std::cout << "(" << value.horizontal << "," << value.vertical << "), ";
  }
  std::cout << std::endl;
}

int crossProductTwoPoints(Point point1, Point point2) {
  cout << "Thing";
}

int main() {
  // Check if shape needs another point
  plannedTransformer();
  return 0;
}
#include <cmath>
#include <iostream>

using namespace std;

typedef struct { float x, y; } Point;

typedef struct { Point p1, p2; } Segment;

float distance(const Point &p1, const Point &p2) {
  return sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2));
}

Point milieu(const Segment &segment) {
  return {(segment.p1.x + segment.p2.x) / 2.f,
          (segment.p1.y + segment.p2.y) / 2.f};
}

int main() {
  Point p1{1, 3}, p2{2, 4}, pt_milieu{0, 0};
  Segment segment{p1, p2};
  cout << "distance: " << distance(p1, p2) << endl;
  pt_milieu = milieu(segment);
  cout << "milieu x: " << pt_milieu.x << " y: " << pt_milieu.y << endl;
  return 0;
}

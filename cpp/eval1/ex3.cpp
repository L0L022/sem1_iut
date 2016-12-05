#include <iostream>

using namespace std;

void inverse(float& n1, float& n2) {
  float tmp = n1;
  n1 = n2;
  n2 = tmp;
}

void ordonne3(float& a, float& b, float& c) {
  if (a > b) inverse(a,b);
  if (a > c) inverse(a, c);
  if (b > c) inverse(b, c);
}

int main() {
  //float a = 11.5, b = 2.1, c = 0.0;
  //float a = 0.0, b = 2.1, c = 11.5;
  //float a = 2.1, b = 0.0, c = 11.5;
  float a = 2.1, b = 11.5, c = 0.0;
  ordonne3(a,b,c);
  cout << a << " " << b << " " << c << endl;
  return 0;
}

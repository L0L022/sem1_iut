#include <iostream>

using namespace std;

void ordonne(float &petit, float &grand) {
  if (petit > grand) {
    float tmp = petit;
    petit = grand;
    grand = tmp;
  }
}

void ordonne3(float &a, float &b, float &c) {
  ordonne(a, b);
  ordonne(a, c);
  ordonne(b, c);
}

int main() {
  // float a = 11.5, b = 2.1, c = 0.0;
  // float a = 0.0, b = 2.1, c = 11.5;
  // float a = 2.1, b = 0.0, c = 11.5;
  float a = 2.1, b = 11.5, c = 0.0;
  ordonne3(a, b, c);
  cout << a << " " << b << " " << c << endl;
  return 0;
}

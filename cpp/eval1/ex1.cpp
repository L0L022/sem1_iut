#include <iostream>

using namespace std;

void fizz_buzz(const size_t& n) {
  for (size_t i = 1; i <= n; i++) {
    if (i%5 == 0 && i%7 == 0) {
      cout << "FizzBuzz" << endl;
    } else if (i%5 == 0) {
      cout << "Fizz" << endl;
    } else if (i%7 == 0) {
      cout << "Buzz" << endl;
    } else {
      cout << i << endl;
    }
  }
}

int main() {
  cout << "un entier:";
  size_t n = 0;
  cin >> n;
  fizz_buzz(n);

  return 0;
}

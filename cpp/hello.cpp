#include <iostream>

using namespace std;

int main() {
  char A = 'Z';
  char B = 'Y';
  char C = 'X';
  int nombre = 0xABCDEF;
  const char *blabla = "azertyuiop";
  cout << hex << nombre << endl;
  cout << blabla << endl;
  return 0;
}

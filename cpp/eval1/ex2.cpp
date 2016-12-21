#include <iostream>

using namespace std;

void inverse(char tab[]) {
  size_t taille = 0;
  for (; tab[taille] != '\0'; ++taille);

  for (size_t i = 0; i<(taille-1)/2; i++) {
    char tmp = tab[i];
    tab[i]=tab[taille-i-1];
    tab[taille-i-1]=tmp;
  }
}

int main() {
  char tab[] = "0123456789";
  cout << tab << endl;
  inverse(tab);
  cout << tab << endl;
  return 0;
}

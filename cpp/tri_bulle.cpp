#include <iostream>
#include <algorithm>
#include <random>

using namespace std;

const size_t taille_max = 50;

void remplir(size_t *tab) {
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<> dis(0, 15);
  for (size_t i = 0; i < taille_max; ++i) {
    tab[i] = dis(gen);
  }
}

void affiche(size_t *tab) {
  for (size_t i = 0; i < taille_max; ++i) {
    cout << tab[i] << ", ";
  }
  cout << endl;
}

void tri(size_t *tab) {
  bool use_swap = false;
  do {
    use_swap = false;
    for (size_t i = 1; i < taille_max; ++i) {
      if(tab[i - 1] > tab[i]) {
        swap(tab[i - 1], tab[i]);
        use_swap = true;
      }
    }
  } while(use_swap);
}

int main() {
  size_t *nombres = new size_t[taille_max];
  remplir(nombres);
  affiche(nombres);
  tri(nombres);
  affiche(nombres);
}

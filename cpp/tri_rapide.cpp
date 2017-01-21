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

void tri(size_t *tab, const size_t debut = 0, const size_t fin = taille_max-1) {
  if(debut < fin) {
    size_t pivot = fin;
    for(size_t i = debut; i < fin; ++i) {
      if(tab[i] > tab[pivot]) {
        swap(tab[i], tab[pivot-1]);
        swap(tab[pivot-1], tab[pivot]);
        ++pivot;
      }
    }
    tri(tab, debut, pivot - 1);
    tri(tab, pivot + 1, fin);
  }
}

int main() {
  size_t *nombres = new size_t[taille_max];
  remplir(nombres);
  affiche(nombres);
  tri(nombres);
  affiche(nombres);
}

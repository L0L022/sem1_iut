#include <iostream>

using namespace std;

struct Maillon {
  float nombre = 0;
  Maillon *suivant = nullptr;
};

struct Liste {
  Maillon *tete = nullptr, *queue = nullptr;
  size_t taille = 0;
};

struct Liste creerListeVide() {
  struct Liste liste;
  return liste;
}

size_t cardinalite(const struct Liste& liste) {
  return liste.taille;
}

bool estVide(const struct Liste& liste) {
  return liste.taille == 0;
}

void ajouterAuRang(struct Liste& liste, const float nombre, const size_t rang) {
  Maillon **iMaillon = &liste.tete;
  for(size_t i = 0; i<rang; ++i) iMaillon = &(*iMaillon)->suivant;

  Maillon *nvMaillon = new Maillon;
  nvMaillon->nombre = nombre;
  nvMaillon->suivant = *iMaillon;

  *iMaillon = nvMaillon;

  if(nvMaillon->suivant == nullptr) liste.queue = *iMaillon;

  ++liste.taille;
}

void enleverAuRang(struct Liste& liste, const size_t rang) {
  Maillon **iMaillon = &liste.tete;
  for(size_t i = 0; i<rang; ++i) iMaillon = &(*iMaillon)->suivant;

  Maillon *tmp = *iMaillon;
  *iMaillon = (*iMaillon)->suivant;
  delete tmp;
  --liste.taille;
}

void afficherListe(const struct Liste liste) {
  cout << "taille: " << liste.taille << endl;
  for(Maillon *iMaillon = liste.tete; iMaillon != nullptr; iMaillon = iMaillon->suivant) {
    cout << iMaillon->nombre << " ";
  }
  cout << endl << endl;
}

int main() {
  struct Liste liste = creerListeVide();
  afficherListe(liste);
  ajouterAuRang(liste, 1, 0);
  afficherListe(liste);
  ajouterAuRang(liste, 2, 0);
  ajouterAuRang(liste, 3, 0);
  ajouterAuRang(liste, 4, 0);
  ajouterAuRang(liste, 5, 0);
  ajouterAuRang(liste, 6, 1);
  ajouterAuRang(liste, 7, 2);
  ajouterAuRang(liste, 8, 7);
  afficherListe(liste);
  enleverAuRang(liste, 0);
  enleverAuRang(liste, 6);
  afficherListe(liste);
  enleverAuRang(liste, 5);
  enleverAuRang(liste, 4);
  enleverAuRang(liste, 3);
  enleverAuRang(liste, 2);
  enleverAuRang(liste, 1);
  afficherListe(liste);
  enleverAuRang(liste, 0);
  afficherListe(liste);

  return 0;
}

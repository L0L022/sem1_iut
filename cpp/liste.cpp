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

Liste creerListeVide() {
  struct Liste liste;
  return liste;
}

size_t cardinalite(const struct Liste &liste) { return liste.taille; }

bool estVide(const struct Liste &liste) { return liste.taille == 0; }

void ajouterAuRang(struct Liste &liste, const float nombre, const size_t rang) {
  Maillon **iMaillon = &liste.tete;
  for (size_t i = 0; i < rang; ++i)
    iMaillon = &(*iMaillon)->suivant;

  Maillon *nvMaillon = new Maillon;
  nvMaillon->nombre = nombre;
  nvMaillon->suivant = *iMaillon;

  *iMaillon = nvMaillon;

  if (nvMaillon->suivant == nullptr)
    liste.queue = *iMaillon;

  ++liste.taille;
}

void enleverAuRang(struct Liste &liste, const size_t rang) {
  Maillon **iMaillon = &liste.tete;
  for (size_t i = 0; i < rang; ++i)
    iMaillon = &(*iMaillon)->suivant;

  Maillon *tmp = *iMaillon;
  *iMaillon = (*iMaillon)->suivant;
  delete tmp;
  --liste.taille;
}

float &avoirAuRang(struct Liste &liste, const size_t rang) {
  Maillon *iMaillon = liste.tete;
  for (size_t i = 0; i < rang; ++i)
    iMaillon = iMaillon->suivant;
  return iMaillon->nombre;
}

void viderListe(struct Liste &liste) {
  while (!estVide(liste))
    enleverAuRang(liste, 0);
}

struct Liste copierListe(struct Liste &liste) {
  struct Liste nvListe = creerListeVide();
  for (Maillon *iMaillon = liste.tete; iMaillon != nullptr;
       iMaillon = iMaillon->suivant) {
    ajouterAuRang(nvListe, iMaillon->nombre, cardinalite(nvListe));
  }
  return nvListe;
}

void afficherListe(const struct Liste liste) {
  cout << "taille: " << liste.taille << endl;
  for (Maillon *iMaillon = liste.tete; iMaillon != nullptr;
       iMaillon = iMaillon->suivant) {
    cout << iMaillon->nombre << ",";
  }
  cout << endl << endl;
}

int main() {
  struct Liste liste = creerListeVide();
  for (size_t i = 0; i < 20; i++) {
    ajouterAuRang(liste, i, 0);
  }
  afficherListe(liste);
  struct Liste liste_2 = copierListe(liste), liste_3 = liste;
  avoirAuRang(liste, 5) = 88;
  ajouterAuRang(liste_2, 99, 0);
  ajouterAuRang(liste_3, 66, 0);
  afficherListe(liste);
  afficherListe(liste_2);
  afficherListe(liste_3);

  return 0;
}

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

void ajouterEnTete(struct Liste &liste, const float nombre) { ajouterAuRang(liste, nombre, 0); }

void ajouterEnQueue(struct Liste &liste, const float nombre) { ajouterAuRang(liste, nombre, cardinalite(liste)); }

void enleverAuRang(struct Liste &liste, const size_t rang) {
  Maillon **iMaillon = &liste.tete;
  for (size_t i = 0; i < rang; ++i)
    iMaillon = &(*iMaillon)->suivant;

  Maillon *tmp = *iMaillon;
  *iMaillon = (*iMaillon)->suivant;
  delete tmp;
  --liste.taille;
}

void suppressionEnTete(struct Liste &liste)  { enleverAuRang(liste, 0); }

void suppressionEnQueue(struct Liste &liste) { enleverAuRang(liste, cardinalite(liste)-1); }

float &avoirAuRang(const struct Liste &liste, const size_t rang) {
  Maillon *iMaillon = liste.tete;
  for (size_t i = 0; i < rang; ++i)
    iMaillon = iMaillon->suivant;
  return iMaillon->nombre;
}

float valeurEnTete(const struct Liste &liste) { return avoirAuRang(liste, 0); }

float valaurEnQueue(const struct Liste &liste) { return avoirAuRang(liste, cardinalite(liste)); }

void viderListe(struct Liste &liste) {
  while (!estVide(liste))
    suppressionEnTete(liste);
}

struct Liste copierListe(const struct Liste &liste) {
  struct Liste nvListe = creerListeVide();
  for (Maillon *iMaillon = liste.tete; iMaillon != nullptr;
       iMaillon = iMaillon->suivant) {
    ajouterAuRang(nvListe, iMaillon->nombre, cardinalite(nvListe));
  }
  return nvListe;
}

void afficherListe(const struct Liste liste) {
  cout << "taille: " << liste.taille << endl;
  for (size_t i = 0; i < cardinalite(liste); i++) {
    cout << "[" << i << "]=" << avoirAuRang(liste, i) << ", ";
  }
  cout << endl << endl;
}

int main() {
  struct Liste liste1 = creerListeVide(), liste2;

  ajouterEnTete(liste1, 1);
  ajouterEnTete(liste1, 2);
  ajouterEnTete(liste1, 3);
  ajouterEnQueue(liste1, 4);
  ajouterEnQueue(liste1, 5);
  ajouterEnQueue(liste1, 6);
  ajouterAuRang(liste1, 7, 3);
  afficherListe(liste1);

  liste2 = liste1;
  afficherListe(liste2);

  liste2 = copierListe(liste1);
  afficherListe(liste2);

  suppressionEnTete(liste1);
  suppressionEnQueue(liste1);
  enleverAuRang(liste1, 3);
  afficherListe(liste1);
  afficherListe(liste2);

  viderListe(liste1);
  afficherListe(liste1);
  afficherListe(liste2);

  viderListe(liste2);
  afficherListe(liste2);

  return 0;
}

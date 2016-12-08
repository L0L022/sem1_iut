#include <iostream>

using namespace std;

const size_t L = 5, C = 5;

//mieux, normalement
bool cherche_mot_dans_mot(const char mot_dans[], const char mot_quoi[]) {
  size_t taille_mot_dans = 0, taille_mot_quoi = 0;
  for (size_t i = 0; mot_dans[i] != '\0'; ++i) ++taille_mot_dans;
  for (size_t i = 0; mot_quoi[i] != '\0'; ++i) ++taille_mot_quoi;

  for(size_t i = 0; i<=taille_mot_dans-taille_mot_quoi; ++i) {
    bool pareil = true;
    for(size_t j = 0; j<taille_mot_quoi; ++j) {
      if(mot_dans[i+j] != mot_quoi[j]) {
        pareil = false;
        break;
      }
    }
    if(pareil) return true;
  }
  return false;
}

bool cherche_mot_dans_grille(const char grille[][C], const char mot[]) {
  size_t taille_mot = 0;
  for (size_t i = 0; mot[i] != '\0'; ++i) ++taille_mot;

  //test horizontal
  for(size_t ligne = 0; ligne < L and taille_mot<=L; ++ligne) {
    char mot_ligne[C];
    for(size_t i = 0; i<C; ++i) mot_ligne[i] = grille[ligne][i];
    if(cherche_mot_dans_mot(mot_ligne, mot)) return true;
  }

  //test vertical
  for(size_t colonne = 0; colonne < C and taille_mot<=C; ++colonne) {
    char mot_colonne[L];
    for(size_t i = 0; i<L; ++i) mot_colonne[i] = grille[i][colonne];
    if(cherche_mot_dans_mot(mot_colonne, mot)) return true;
  }
  return false;
}

//bof bof
bool cherche_mot_pas_beau(const char grille[][C], const char mot[]) {
  size_t taille = 0;
  for (size_t i = 0; mot[i] != '\0'; ++i) {
    ++taille;
  }

  if (taille <= C) {
    //test vertical
    for(size_t colonne = 0; colonne<C; ++colonne) {
      for(size_t i = 0; i<=C-taille; ++i) {
        bool trouve = true;
        for(size_t i_mot = 0; i_mot<taille; ++i_mot) {
          if(grille[i+i_mot][colonne] != mot[i_mot]) {
            trouve = false;
            break;
          }
        }
        if(trouve) return true;
      }
    }
  }

  if (taille <= L) {
    //test horizontal
    for(size_t ligne = 0; ligne<L; ++ligne) {
      for(size_t i = 0; i<=L-taille; ++i) {
        bool trouve = true;
        for(size_t i_mot = 0; i_mot<taille; ++i_mot) {
          if(grille[ligne][i+i_mot] != mot[i_mot]) {
            trouve = false;
            break;
          }
        }
        if(trouve) return true;
      }
    }
  }

  return false;
}

bool cherche_mot(const char grille[][C], const char mot[]) {
  //return cherche_mot_pas_beau(grille, mot);
  return cherche_mot_dans_grille(grille, mot);
}

int main() {
  char grille[L][C] = {
    {'A', 'R', 'T', 'R', 'G'},
    {'Z', 'A', 'M', 'A', 'N'},
    {'A', 'T', 'Y', 'N', 'Q'},
    {'B', 'A', 'Z', 'A', 'R'},
    {'R', 'E', 'D', 'O', 'C'}
  };
  cout << "exercice" << endl;
  cout << cherche_mot(grille, "BAZAR") << endl;
  cout << cherche_mot(grille, "MANGE") << endl;
  cout << cherche_mot(grille, "RAT") << endl;
  cout << endl;

  cout << "tests" << endl;
  cout << cherche_mot(grille, "ARTRG") << endl;
  cout << cherche_mot(grille, "ARTR") << endl;
  cout << cherche_mot(grille, "RTRG") << endl;
  cout << cherche_mot(grille, "RTR") << endl;
  cout << cherche_mot(grille, "RED") << endl;

  cout << cherche_mot(grille, "TMYZD") << endl;
  cout << cherche_mot(grille, "MYZ") << endl;
  cout << cherche_mot(grille, "TMYZ") << endl;
  cout << cherche_mot(grille, "YZD") << endl;

  cout << cherche_mot(grille, "A") << endl;
  cout << cherche_mot(grille, "F") << endl;

  cout << cherche_mot(grille, "HDJSKHKDJSHSD") << endl;
  return 0;
}

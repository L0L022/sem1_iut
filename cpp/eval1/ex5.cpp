#include <iostream>

using namespace std;

const size_t L = 5, C = 5;

bool cherche_mot(char grille[][C], const char mot[]) {
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

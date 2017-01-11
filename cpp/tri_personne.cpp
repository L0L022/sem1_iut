#include <iostream>
#include <string>
#include <fstream>

using namespace std;

typedef struct {
  string nom, prenom, num;
} Personne;

const size_t personnes_max = 255;

size_t longueurMot(const char *mot) {
  size_t longueur = 0;
  for(; mot[longueur] != '\0'; ++longueur)
    ;
  return longueur;
}

bool Equal(const char *ch1, const char *ch2) {
  bool pareil = longueurMot(ch1) == longueurMot(ch2);
  size_t i = 0;
  for(; pareil and ch1[i] != '\0'; ++i)
    pareil = ch1[i] == ch2[i];
  return pareil;
}

bool Equal(const string &ch1, const string &ch2) {
  return Equal(ch1.c_str(), ch2.c_str());
}

int CompareTo(const string &num1, const string &num2) {
  if(num1 < num2)
    return -1;
  else if(num1 > num2)
    return 1;
  else
    return 0;
}

int RechercheSeq(const Personne *personnes, const string &num) {
  for (size_t i = 0; i < personnes_max; ++i)
    if(Equal(personnes[i].num, num))
      return i;
  return -1;
}

int RechercheDich(const Personne *personnes, const string &num) {
  int min = 0, max = personnes_max - 1, i;
  while(min <= max) {
    i = ((max + min) - (max + min)%2)/2;
    cout << min << " < " << i << " < " << max << endl;
    cout << personnes[i].num << " " << num << " " << CompareTo(personnes[i].num, num) << endl;
    switch (CompareTo(personnes[i].num, num)) {
      case -1:
        min = i + 1;
        break;
      case 1:
        max = i - 1;
        break;
      case 0:
        return i;
        break;
    }
  }
  return -1;
}

//$ for i in {1..255}; do echo $RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM | head -c 10 >> num.txt; echo >> num.txt; done && sort num.txt -o num.txt

int main() {
  Personne *personnes = new Personne[personnes_max];
  std::ifstream nums("num.txt");
  for (size_t i = 0; i < personnes_max; i++)
    getline(nums, personnes[i].num);
  cout << RechercheDich(personnes, "1001419684") << endl; //premier
  cout << RechercheDich(personnes, "9351107193") << endl; //dernier
  cout << RechercheDich(personnes, "1700716727") << endl; //56
  cout << RechercheDich(personnes, "3280177401") << endl; //194
  delete[] personnes;
  return 0;
}

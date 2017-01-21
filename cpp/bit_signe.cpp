#include <iostream>
#include <string>
#include <bitset>

using namespace std;

void show(char *ptr) {
    // de sizeof(short int) = 2 à 0 avec des pas de -1
    // parce que: https://fr.wikipedia.org/wiki/Endianness
    for(int i = sizeof(short int) - 1; i >= 0 ; --i) {
      // bitset<8> représente 8 bit
      // on s'en sert pour faciliter l'affichage sous forme binaire
      cout << bitset<8>(ptr[i]) << ' ';
    }
    cout << endl;
}

void show_nb(const short int nb) {
  short int neg = -nb;
  cout << ' ' << nb << " : ";
  show((char *)&nb); // transforme un pointeur sur short int en pointeur sur char
  cout << neg << " : ";
  show((char *)&neg);
  cout << endl;
}

int main()
{
  int exemple_nb(53);
  bitset<8> exemple(exemple_nb);
  cout << "Pour rappel le bit de signe et le premier bit tout à gauche, si il vaut zero alors le nombre est positif, si il vaut un alors le nombre est négatif." << endl << endl;
  cout << "Exemple on veut coder -"<<exemple_nb<<"." << endl;
  cout << "53 en binaire : " <<  exemple << endl;
  cout << "Pour coder une nombre négatif il faut faire le complément à 1 : C'est mettre des zéros à la place des uns et des uns à la place des zéros." << endl;
  cout << exemple;
  exemple = exemple.flip();
  cout << " devient : " << exemple << endl;
  cout << "Puis il suffit de rajouter un." << endl;
  exemple |= bitset<8>(00000001);
  cout << "Résultat : " << exemple << endl;
  cout << "Le premier bit vaut bien zéro." << endl << endl;
  cout << "Si on nous donne : " << exemple << endl;
  cout << "On voit que le premier bit vaut un, donc le nombre est négatif." << endl;
  cout << "Il faut donc refaire les opérations pour avoir le nombre." << endl;
  cout << "Le complément à 1 : " << exemple;
  exemple = exemple.flip();
  cout << " devient " << exemple << endl;
  cout << "Et l'ajout de un : " << exemple;
  exemple |= bitset<8>(00000001);
  cout << " devient : " << exemple << endl;
  cout << "On a bien retrouvé notre nombre de départ." << endl << endl;

  cout << "Exemples de codages :" << endl;
  show_nb(0);
  show_nb(1);
  show_nb(2);
  show_nb(10);
  show_nb(15);
  show_nb(16);
  show_nb(4095);
  show_nb(32767);
  return 0;
}

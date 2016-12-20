#include <iostream>
using namespace std;

typedef struct {
  // size_t = unsigned int mais c'est plus stylé
  size_t taille_allouee;
  char *tampon;
} Chaine;

void creerChaine(Chaine &chaine, const size_t taille) {
  chaine.taille_allouee = taille;
  chaine.tampon = new char[taille];
  chaine.tampon[0] = '\0';
}

void afficherChaine(const Chaine &chaine) {
  for (const char *ptr = chaine.tampon; *ptr != '\0'; ++ptr) cout << *ptr;
  cout << endl; //normalement faut pas mais c'est quand même plus mieux
}

size_t longueurChaine(const Chaine &chaine) {
	const char *ptr = nullptr;
  for (ptr = chaine.tampon; *ptr != '\0'; ++ptr)
    ;
  return ptr - chaine.tampon;
}

void detruireChaine(Chaine &chaine) {
  delete[] chaine.tampon;
	chaine.tampon = nullptr;
  chaine.taille_allouee = 0;
}

void agrandirChaine(Chaine &chaine, size_t taille) {
  if (taille > chaine.taille_allouee) {
		char *nv_tampon = new char[taille];
		char *i_tampon = chaine.tampon;
		char *i_nv_tampon = nv_tampon;
		while (*i_tampon != '\0') *i_nv_tampon++ = *i_tampon++;
		delete[] chaine.tampon;
		chaine.tampon = nv_tampon;
		chaine.taille_allouee = taille;
  }
}

void affecterChaine(Chaine &chaine, const char *str) {
  char *i_tampon = chaine.tampon;
  const char *i_str = str;
  while (*i_str != '\0') *i_tampon++ = *i_str++;
	*i_tampon = '\0';
}

int main() {
  Chaine c;
  creerChaine(c, 50);
	afficherChaine(c);
  affecterChaine(c, "le c++ c'est vraiment trop facile !");
	afficherChaine(c);
  affecterChaine(c, "le bash c'est facile !");
  afficherChaine(c);

	agrandirChaine(c, 1000);
	afficherChaine(c);
	affecterChaine(c, "Sempezi cubut bebhebdez anceoba uckiiso hutnewu nuvmi cavidu lo se mup subhoij ono vodacfe vusuov. Cowizto rubeg ovupi go la abtuaso orjeg eturipcu votumleb he cod hatna gemroh cilji kanji. Hetzeena reventu lav votabi holtiw ne jolilku evna ke ke uneodunu obasigel. Ecizo ciipu tumzezes ujo bo alcum liv ofi fotva vivhotok newo kulamokab zenhim besro zimowi leajo. Osuwo giner ohmindop sejin ceg nosezmop abo apiku weg bod ret ecu pavrom bag. Dod sezrizke gejud fowdep abfugre tidwirku lias riset kod ikolazbo cadre geva zeraz haci jutamo pudu tebu nagivcin.");
	afficherChaine(c);

  return 0;
}

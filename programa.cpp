#include <fstream>
#include <iostream>

#define BINARYFILE_CLIENTS "client.dat"
#define TEXTFILE_CLIENTS "client.txt"

#define BINARYFILE_ARTICLES "article.dat"
#define TEXTFILE_ARTICLES "article.txt"

using namespace std;

typedef struct {
  char nom[20];
  bool alta;
  char adreca[20];
  int nrCompte;
} Client;

typedef struct {
	char nom[20];
	bool registrat;
	char nrSerie[10];
	int preuCompra;
	int preuVenta;
} Article;

void escriuTextClient(Client client) {
  ofstream file(TEXTFILE_CLIENTS, ios::app | ios::out);
  file << "Nom: " << client.nom << endl;
  file << "Alta: " << client.alta << endl;
  file << "Adreca: " << client.adreca << endl;
  file << "Nr. Compte: " << client.nrCompte << endl;
  file.close();
}

void escriuTextArticle(Article article) {
  ofstream file(TEXTFILE_ARTICLES, ios::app | ios::out);
  file << "Nom: " << article.nom << endl;
  file << "Registrat: " << article.registrat << endl;
  file << "Nr. serie: " << article.nrSerie << endl;
  file << "Preu compra: " << article.preuCompra << endl;
  file << "Preu venta: " << article.preuVenta << endl;
  file.close();
}

void escriuBinariClient(Client client) {
  ofstream file(BINARYFILE_CLIENTS, ios::app | ios::binary | ios::out);
  file.write(reinterpret_cast<char *>(&client), sizeof(Client));
  file.close();
}

void escriuBinariArticle(Article article) {
  ofstream file(BINARYFILE_ARTICLES, ios::app | ios::binary | ios::out);
  file.write(reinterpret_cast<char *>(&article), sizeof(Article));
  file.close();
}

void rebreTextClient() {
  ifstream file(TEXTFILE_CLIENTS);
  string line;
  int lineNumber = 0, clientCount = 0;

  while (getline(file, line)) {
	if (lineNumber % 4 == 0) {
  	clientCount++;
  	if (clientCount != 1)
    	cout << '\n';
  	cout << "Client numero: " << clientCount << endl;
	}

	cout << line << '\n';
	lineNumber++;
  }
}

void rebreTextArticle() {
  ifstream file(TEXTFILE_ARTICLES);
  string line;
  int lineNumber = 0, articleCount = 0;

  while (getline(file, line)) {
	if (lineNumber % 5 == 0) {
  	articleCount++;
  	if (articleCount != 1)
    	cout << '\n';
  	cout << "Article numero: " << articleCount << endl;
	}

	cout << line << '\n';
	lineNumber++;
  }
}

void rebreBinariClient() {
  ifstream file(BINARYFILE_CLIENTS, ios::in | ios::binary);

  int clientCount = 0;

  while (file.peek() != EOF) {

	clientCount++;
	if (clientCount != 1)
  	cout << '\n';
	cout << "Client numero: " << clientCount << endl;

	Client client;
	file.read(reinterpret_cast<char *>(&client), sizeof(Client));
	cout << "Nom: " << client.nom << endl;
	cout << "Alta: " << client.alta << endl;
	cout << "Adreca: " << client.adreca << endl;
	cout << "Nr. Compte: " << client.nrCompte << endl;
  }
}

void rebreBinariArticle() {
  ifstream file(BINARYFILE_ARTICLES, ios::in | ios::binary);

  int articleCount = 0;

  while (file.peek() != EOF) {

	articleCount++;
	if (articleCount != 1)
  	cout << '\n';
	cout << "Article numero: " << articleCount << endl;

	Article article;
	file.read(reinterpret_cast<char *>(&article), sizeof(Article));
	cout << "Nom: " << article.nom << endl;
	cout << "Registrat: " << article.registrat << endl;
	cout << "Nr. serie: " << article.nrSerie << endl;
	cout << "Preu compra: " << article.preuCompra << endl;
	cout << "Preu venta: " << article.preuVenta << endl;
  }
}

int main() {
  Article exemple = {"Hola", false, "123456789", 10, 12};
  escriuBinariArticle(exemple);
  rebreBinariArticle();
}


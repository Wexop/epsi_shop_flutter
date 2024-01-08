class Article {
  String nom;
  final String image;
  String description;
  num prix;
  String categorie;
  num quantite = 0;

  Article(
      {required this.nom,
      required this.image,
      required this.description,
      required this.prix,
      required this.categorie});

  String prixEuro() {
    return "$prix €";
  }

  String afficher() {
    return "nom : $nom, prix : ${prixEuro()}";
  }
}

void main() {
  final List<Article> listArticle = [
    Article(
        nom: "Café",
        image: "",
        description: "Café au sucre",
        prix: 3.80,
        categorie: "Soif"),
    Article(
      nom: "Biscuit",
      image: "",
      description: "Biscuit délicieux",
      prix: 1.34,
      categorie: "Manger",
    )
  ];

  for (var element in listArticle) {
    print(element.afficher());
  }
}

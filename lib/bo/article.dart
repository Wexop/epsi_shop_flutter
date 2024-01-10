class Article {
  late num id;
  late String nom;
  late String image;
  late String description;
  late num prix;
  late String categorie;
  late num quantite = 0;

  Article(
      {required this.nom,
      required this.image,
      required this.description,
      required this.prix,
      required this.categorie});

  Article.fromJson(dynamic jsonArticle) {
    id = jsonArticle["id"];
    nom = jsonArticle["title"];
    image = jsonArticle["image"];
    description = jsonArticle["description"];
    prix = jsonArticle["price"];
    categorie = jsonArticle["category"];
  }

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

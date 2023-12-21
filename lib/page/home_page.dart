import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageSate();
}

class HomePageSate extends State<HomePage> {
  final List<Article> listArticles = <Article>[
    Article(
        nom: "Test",
        image:
            "https://www.histoiredor.com/dw/image/v2/BCQS_PRD/on/demandware.static/-/Sites-THOM_CATALOG/default/dwfe351ec1/images/B3DFBTB794-view1.jpg?sw=1024&sh=1024",
        description: "test",
        prix: 3.37,
        categorie: "test"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                "E-Commerce",
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Center(
                child: ListView.builder(
                  itemCount: listArticles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.blueAccent,
                      trailing: TextButton(
                        child: Text("Ajouter"),
                        onPressed: () {},
                      ),
                      title: Text(listArticles[index].nom),
                      subtitle: Text(
                        listArticles[index].prixEuro(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Image.network(
                        "https://www.histoiredor.com/dw/image/v2/BCQS_PRD/on/demandware.static/-/Sites-THOM_CATALOG/default/dwfe351ec1/images/B3DFBTB794-view1.jpg?sw=1024&sh=1024",
                        scale: 1,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Votre panier est actuellement vide"),
        Icon(Icons.image)
      ],
    );
  }
}

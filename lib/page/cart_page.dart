import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageSate();
}

class CartPageSate extends State<CartPage> {
  final List<Article> listArticles = <Article>[
    Article(
        nom: "Test",
        image: "test",
        description: "test",
        prix: 3.37,
        categorie: "test"),
  ];

  void deleteArticle(index) {
    setState(() {
      listArticles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                "Votre panier",
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Votre panier est de : "),
                  Text("00.00€"),
                ],
              ),
              Center(
                child: listArticles.isEmpty
                    ? const EmptyCart()
                    : ListView.builder(
                        itemCount: listArticles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.blueAccent,
                            trailing: ElevatedButton(
                                onPressed: () => deleteArticle(index),
                                child: const Icon(Icons.delete)),
                            title: Text(listArticles[index].nom),
                            subtitle: Text(listArticles[index].description),
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

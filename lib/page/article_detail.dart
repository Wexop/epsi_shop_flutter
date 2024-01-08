import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class ArticleDetailPage extends StatelessWidget {
  Article article;

  ArticleDetailPage({super.key, required this.article});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                "Détail sur l'article",
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: Text(
                article.nom,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Image.network(
                article.image,
                width: 200,
                height: 200,
              ),
              Center(
                  child: Text(
                article.prixEuro(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
              Center(
                  child: Text('Catégorie: ${article.categorie}',
                      style: const TextStyle(fontSize: 15))),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Row(
                  children: [
                    Text(
                      'Description du produit',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(article.description,
                      style: const TextStyle(fontSize: 17))),
              Consumer<Cart>(builder: (context, cart, child) {
                return TextButton(
                  onPressed: () => cart.add(article),
                  child: const Text("Ajouter cet article au panier"),
                );
              })
            ],
          ),
        ));
  }
}

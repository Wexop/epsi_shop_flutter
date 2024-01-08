import 'dart:convert';

import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageSate();
}

class HomePageSate extends State<HomePage> {
  final List<Article> listArticles = <Article>[];

  @override
  void initState() {
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var result = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        result.forEach((value) => listArticles.add(Article(
            nom: value["title"],
            image: value["image"],
            description: value["description"],
            prix: value["price"],
            categorie: value["category"])));
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  final articleSelected = <Article>[];

  onAdd(Article article) {
    setState(() {
      context.read<Cart>().add(article);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                    onPressed: () =>
                        context.go("/cart", extra: articleSelected),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart),
                        Text(
                          context.watch<Cart>().articles.length.toString(),
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              )
            ],
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
                child: ListView.separated(
                  itemCount: listArticles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.black26,
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => onAdd(listArticles[index]),
                              icon: const Icon(Icons.add),
                            ),
                            IconButton(
                              onPressed: () => context.go('/detail',
                                  extra: listArticles[index]),
                              icon: const Icon(Icons.info),
                            )
                          ]),
                      title: Text(listArticles[index].nom),
                      subtitle: Text(
                        listArticles[index].prixEuro(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Image.network(
                        listArticles[index].image,
                        scale: 1,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 20,
                  ),
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

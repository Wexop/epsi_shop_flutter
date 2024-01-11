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

  Future<Iterable<Article>> fetchArticles() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var result = jsonDecode(response.body) as List<dynamic>;

      return result.map((value) => Article.fromJson(value));
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
                          context.watch<Cart>().getItemsNumber().toString(),
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                    onPressed: () => context.go("/aboutus"),
                    child: const Icon(Icons.info_outline_rounded)),
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
                child: FutureBuilder<Iterable<Article>>(
                  future: fetchArticles(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      var articles = snapshot.data!.toList();
                      return ListView.separated(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.black26,
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () => onAdd(articles[index]),
                                    icon: const Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () => context.go('/detail',
                                        extra: articles[index]),
                                    icon: const Icon(Icons.info),
                                  )
                                ]),
                            title: Text(articles[index].nom),
                            subtitle: Text(
                              articles[index].prixEuro(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: Image.network(
                              articles[index].image,
                              scale: 1,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 20,
                        ),
                      );
                    } else {
                      return const Text("NO DATA");
                    }
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

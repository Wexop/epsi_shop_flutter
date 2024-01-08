import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageSate();
}

class HomePageSate extends State<HomePage> {
  final List<Article> listArticles = <Article>[
    Article(
      nom: "Collier en Or",
      image:
          "https://www.cdiscount.com/pdt2/9/0/9/1/300x300/ave2009931149909/rw/collier-palmier-or-jaune-18-carats-chute.jpg",
      description:
          "Un magnifique collier en or, parfait pour toutes les occasions.",
      prix: 149.99,
      categorie: "Bijoux",
    ),
    Article(
      nom: "Montre élégante",
      image:
          "https://i0.wp.com/boutiquedelily.com/wp-content/uploads/2018/07/Montre-%C3%A9l%C3%A9gante-dor%C3%A9e-strass.jpg?fit=640%2C590&ssl=1",
      description:
          "Une montre élégante qui ajoute une touche de sophistication à votre style.",
      prix: 79.99,
      categorie: "Accessoires",
    ),
    Article(
      nom: "Boucles d'oreilles en argent",
      image:
          "https://fr.arthusbertrand.com/media/catalog/product/cache/a13e371ff89486190d360c321b80a612/b/o/boucles-oreilles-ruban-argent-sku-a10758x000-a.jpg",
      description:
          "Des boucles d'oreilles en argent avec un design moderne et chic.",
      prix: 49.99,
      categorie: "Bijoux",
    ),
    Article(
      nom: "Sac à main en cuir",
      image:
          "https://www.duponddurand.com/14128-thickbox_default/benicha-sac-%C3%A0-main-en-cuir-.jpg",
      description:
          "Un sac à main en cuir de haute qualité, spacieux et élégant.",
      prix: 129.99,
      categorie: "Mode",
    ),
    Article(
      nom: "Bracelet en perles",
      image: "https://www.meilys.fr/photo/14892/400_1.jpg",
      description:
          "Un bracelet en perles naturelles, symbolisant l'élégance et la simplicité.",
      prix: 34.99,
      categorie: "Bijoux",
    ),
  ];

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
                child: ListView.builder(
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

import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  List<Article> articles;
  num cartPrice = 0;

  CartPage({super.key, required this.articles});

  @override
  State<CartPage> createState() => CartPageSate();
}

class CartPageSate extends State<CartPage> {
  CartPageSate();

  void deleteArticle(index) {
    setState(() {
      widget.articles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    num price = 0;
    widget.articles.forEach((element) {
      price += element.prix;
    });
    setState(() {
      widget.cartPrice = price;
    });

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Votre panier est de : "),
                  Text("${widget.cartPrice.toString()} €"),
                ],
              ),
              Center(
                child: widget.articles.isEmpty
                    ? const EmptyCart()
                    : ListView.builder(
                        itemCount: widget.articles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.blueAccent,
                            trailing: ElevatedButton(
                                onPressed: () => deleteArticle(index),
                                child: const Icon(Icons.delete)),
                            title: Text(widget.articles[index].nom),
                            subtitle: Text(widget.articles[index].description),
                            leading: Image.network(
                              widget.articles[index].image,
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

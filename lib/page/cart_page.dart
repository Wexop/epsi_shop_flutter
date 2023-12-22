import 'package:epsi_shop/bo/article.dart';
import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  num cartPrice = 0;

  CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageSate();
}

class CartPageSate extends State<CartPage> {
  CartPageSate();

  void deleteArticle(Article article, BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    num price = 0;
    context.watch<Cart>().articles.forEach((element) {
      price += element.prix;
    });
    setState(() {
      widget.cartPrice = num.parse((price).toStringAsFixed(2));
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Votre panier est de : "),
                  Text("${widget.cartPrice.toString()} €"),
                ],
              ),
              Consumer<Cart>(builder: (context, cart, child) {
                return cart.articles.isEmpty
                    ? const Center(child: EmptyCart())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: cart.articles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: Colors.blueAccent,
                              trailing: ElevatedButton(
                                  onPressed: () =>
                                      cart.remove(cart.articles[index]),
                                  child: const Icon(Icons.delete)),
                              title: Text(
                                  context.watch<Cart>().articles[index].nom),
                              subtitle: Text(cart.articles[index].description),
                              leading: Image.network(
                                cart.articles[index].image,
                                scale: 1,
                              ),
                            );
                          },
                        ),
                      );
              })
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

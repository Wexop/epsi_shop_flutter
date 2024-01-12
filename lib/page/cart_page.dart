import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  num cartPrice = 0;

  CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageSate();
}

class CartPageSate extends State<CartPage> {
  CartPageSate();

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.cartPrice =
          num.parse(context.watch<Cart>().getTotalPrice().toStringAsFixed(2));
    });

    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                "Votre panier",
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        floatingActionButton: context.watch<Cart>().articles.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () => context.go("/cart/payement"),
                label: const Text('Procéder au paiement'),
                icon: const Icon(Icons.payment),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Votre panier est de : "),
                    Text("${widget.cartPrice.toString()} €"),
                  ],
                ),
              ),
              Consumer<Cart>(builder: (context, cart, child) {
                return cart.articles.isEmpty
                    ? const Center(child: EmptyCart())
                    : Expanded(
                        child: ListView.separated(
                          itemCount: cart.articles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              trailing: ElevatedButton(
                                  onPressed: () =>
                                      cart.remove(cart.articles[index]),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  )),
                              title: Text(cart.articles[index].nom),
                              subtitle: Text(
                                  "Prix: ${cart.articles[index].prixEuro()} x ${cart.articles[index].quantite}"),
                              leading: Image.network(
                                cart.articles[index].image,
                                scale: 1,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 20,
                          ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class AdresseCard extends StatelessWidget {
  const AdresseCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Consumer<Cart>(builder: (context, cart, child) {
          num sousTotalPrice =
              num.parse(cart.getTotalPrice().toStringAsFixed(2));
          num Tva = num.parse((sousTotalPrice * 0.2).toStringAsFixed(2));
          num totalPrice = num.parse((sousTotalPrice + Tva).toStringAsFixed(2));

          return const FractionallySizedBox(
            widthFactor: 0.95,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Michel Le Poney",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "8 rue des ouvertures de portes",
                      ),
                      Text(
                        "93024 CORBEAUX",
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

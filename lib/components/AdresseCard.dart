import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';
import 'ResumeText.dart';

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
              child: Column(
                children: [
                  ResumeText(
                    text1: "Michel Le Poney",
                    text2: "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ResumeText(
                    text1: "8 rue des ouvertures de portes",
                    text2: "",
                  ),
                  ResumeText(
                    text1: "93024 CORBEAUX",
                    text2: "",
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

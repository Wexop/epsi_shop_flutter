import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';
import 'resume_text.dart';

class PayementResumeCard extends StatelessWidget {
  const PayementResumeCard({
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

          return FractionallySizedBox(
            widthFactor: 0.95,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const ResumeText(
                    text1: "Récapitulation de votre commande",
                    text2: "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ResumeText(
                    text1: "Sous-Total",
                    text2: "${sousTotalPrice.toString()}€",
                  ),
                  const ResumeText(
                    text1: "Vous économisez",
                    text2: "-0.0€",
                    style: TextStyle(color: Colors.green),
                  ),
                  ResumeText(
                    text1: "TVA",
                    text2: "${Tva.toString()}€",
                  ),
                  ResumeText(
                    text1: "TOTAL",
                    text2: "${totalPrice.toString()}€",
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

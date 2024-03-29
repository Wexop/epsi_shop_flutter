import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../bo/cart.dart';
import '../components/adresse_card.dart';
import '../components/payement_block.dart';
import '../components/resume_payement_card.dart';
import '../components/resume_text.dart';

class PayementPage extends StatefulWidget {
  num cartPrice = 0;
  String? blockSelected;

  PayementPage({super.key});

  @override
  State<PayementPage> createState() => PayementPageState();
}

class PayementPageState extends State<PayementPage> {
  PayementPageState();

  static const snackBar = SnackBar(
    content: Text('Votre achat à été confirmé !'),
    showCloseIcon: true,
  );

  selectBlock(String name) {
    setState(() {
      widget.blockSelected = name;
    });
  }

  onPressPayement() {
    http
        .post(Uri.parse('http://ptsv3.com/t/EPSISHOPC2/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'total': context.read<Cart>().getTotalPrice(),
              'payementMethode': widget.blockSelected,
              'adresse': "8 rue des ouvertures de portes",
            }))
        .then((value) => {print(value.body)});

    context.read<Cart>().removeAll();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text(
              "Finalisation de votre commande",
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      floatingActionButton: widget.blockSelected != null
          ? FloatingActionButton.extended(
              onPressed: () => onPressPayement(),
              label: const Text("Confirmer l'achat"),
              icon: const Icon(Icons.payment_outlined),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: FractionallySizedBox(
          heightFactor: 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const PayementResumeCard(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 8),
                    child: ResumeText(
                      text1: "Adresse de livraison",
                      text2: "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const AdresseCard(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 8),
                    child: ResumeText(
                      text1: "Méthode de paiement",
                      text2: "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PayementBlock(
                            selected: widget.blockSelected == "ApplePay",
                            onPress: () => selectBlock("ApplePay"),
                            icon: FontAwesomeIcons.ccApplePay,
                          ),
                          PayementBlock(
                            selected: widget.blockSelected == "Visa",
                            onPress: () => selectBlock("Visa"),
                            icon: FontAwesomeIcons.ccVisa,
                          ),
                          PayementBlock(
                            selected: widget.blockSelected == "MasterCard",
                            onPress: () => selectBlock("MasterCard"),
                            icon: FontAwesomeIcons.ccMastercard,
                          ),
                          PayementBlock(
                            selected: widget.blockSelected == "PayPal",
                            onPress: () => selectBlock("PayPal"),
                            icon: FontAwesomeIcons.ccPaypal,
                          ),
                        ],
                      )),
                ],
              ),
              const Text(
                  "En cliquant sur << confirmer l'achat >> vous accepter les Conditions de Vente de EPSI Shop International. Besoin d'aide ? Va voir ailleur \n"
                  "Veuillez vous préparer mentalement à ne rien recevoir au bout d'un mois. Pas de contact avec notre équipe possible, nous sommes une belle arnaque. \n\n"
                  "Merci pour votre argent !")
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/adresse_card.dart';
import '../components/payement_block.dart';
import '../components/resume_payement_card.dart';
import '../components/resume_text.dart';

class PayementPage extends StatefulWidget {
  num cartPrice = 0;
  String blockSelected = "ApplePay";

  PayementPage({super.key});

  @override
  State<PayementPage> createState() => PayementPageState();
}

class PayementPageState extends State<PayementPage> {
  PayementPageState();

  selectBlock(String name) {
    setState(() {
      widget.blockSelected = name;
    });
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        label: const Text("Confirmer l'achat"),
        icon: const Icon(Icons.payment_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
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
      ),
    );
  }
}

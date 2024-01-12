import 'package:flutter/material.dart';

import '../components/AdresseCard.dart';
import '../components/ResumePayementCard.dart';
import '../components/ResumeText.dart';

class PayementPage extends StatefulWidget {
  num cartPrice = 0;

  PayementPage({super.key});

  @override
  State<PayementPage> createState() => PayementPageState();
}

class PayementPageState extends State<PayementPage> {
  PayementPageState();

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
      body: const Padding(
        padding: EdgeInsets.all(2.0),
        child: Column(
          children: [
            PayementResumeCard(),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 8),
              child: ResumeText(
                text1: "Adresse de livraison",
                text2: "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            AdresseCard(),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 8),
              child: ResumeText(
                text1: "Méthode de payement",
                text2: "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

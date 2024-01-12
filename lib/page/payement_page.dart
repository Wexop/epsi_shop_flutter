import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/AdresseCard.dart';
import '../components/ResumePayementCard.dart';
import '../components/ResumeText.dart';

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

class PayementBlock extends StatefulWidget {
  bool selected;
  Function onPress;
  IconData icon;

  PayementBlock(
      {super.key,
      required this.selected,
      required this.onPress,
      required this.icon});

  @override
  State<PayementBlock> createState() => PayementBlockState();
}

class PayementBlockState extends State<PayementBlock> {
  PayementBlockState();

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: widget.selected,
      badgeContent: const SizedBox(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        ),
      ),
      badgeStyle: badges.BadgeStyle(badgeColor: Theme.of(context).primaryColor),
      badgeAnimation: const badges.BadgeAnimation.scale(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color:
                widget.selected ? Theme.of(context).primaryColor : Colors.black,
            width: 3,
          ),
        ),
        child: InkWell(
            onTap: () => widget.onPress(),
            child: SizedBox(
                width: 75,
                height: 75,
                child: Center(
                    child: FaIcon(
                  widget.icon,
                  size: 40,
                )))),
      ),
    );
  }
}

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  color: widget.selected
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                )))),
      ),
    );
  }
}

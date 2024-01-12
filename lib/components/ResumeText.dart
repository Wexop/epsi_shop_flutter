import 'package:flutter/cupertino.dart';

class ResumeText extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle? style;

  const ResumeText({
    required this.text1,
    required this.text2,
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: style,
        ),
        Text(text2),
      ],
    );
  }
}

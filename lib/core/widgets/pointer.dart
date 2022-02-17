import 'package:flutter/material.dart';

import '../constant/styles.dart';

class Pointer extends StatelessWidget {
  const Pointer({
    Key? key,
    required this.assetImage,
    required this.value,
    required this.text,
  }) : super(key: key);
  final String assetImage;
  final String value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(child: Image.asset(assetImage)),
        const SizedBox(height: 20),
        Text(value, style: pointerValueStyle),
        const SizedBox(height: 10),
        Text(text, style: pointerTextStyle(context)),
      ],
    );
  }
}

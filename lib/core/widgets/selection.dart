import 'package:flutter/material.dart';

import '../constant/styles.dart';

class Selection extends StatelessWidget {
  const Selection({Key? key, required this.text, required this.fun}) : super(key: key);
  final String text;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text, style: selectionTextStyle(context),), 
      onPressed: () => fun()
    );
  }
}

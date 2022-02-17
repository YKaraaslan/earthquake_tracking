import 'package:flutter/material.dart';

const pointerValueStyle = TextStyle(
  fontSize: 18.0,
);

TextStyle pointerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 13.0,
    color: Theme.of(context).splashColor.withOpacity(1),
  );
}

TextStyle selectionTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 10.0,
    color: Theme.of(context).splashColor.withOpacity(1),
  );
}

const textMainStyle = TextStyle(
  fontSize: 30.0,
);

const listTileValueStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);
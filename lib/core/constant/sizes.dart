import 'package:flutter/material.dart';

class Sizes {
  static double height_100percent (BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double height_70percent (BuildContext context) {
    return MediaQuery.of(context).size.height * 0.7;
  }
  
  static double height_30percent (BuildContext context) {
    return MediaQuery.of(context).size.height * 0.3;
  }

  static double height_25percent (BuildContext context) {
    return MediaQuery.of(context).size.height * 0.25;
  }

  
  
  static double width_90percent (BuildContext context) {
    return MediaQuery.of(context).size.width * 0.9;
  }

  static double width_70percent (BuildContext context) {
    return MediaQuery.of(context).size.width * 0.7;
  }
}
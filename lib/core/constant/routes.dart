import 'package:flutter/material.dart';

import '../../view/details/details_view.dart';
import '../../view/home/home_view.dart';

class Routes {

  static const String homeView = '/home_view';
  static const String details = '/details';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {

  return {
    homeView: (context) => const HomeView(),
    details: (context) => const DetailsView(),
    };
  }
}
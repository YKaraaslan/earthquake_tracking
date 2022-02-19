import 'package:flutter/material.dart';

import '../../view/details/details_view.dart';
import '../../view/home/home_view.dart';
import '../../view/skeleton/skeleton_view.dart';

class Routes {

  static const String homeView = '';
  static const String details = '/details';
  static const String skeleton = '/skeleton';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {

  return {
    homeView: (context) => const HomeView(),
    details: (context) => const DetailsView(),
    skeleton: (context) => const SkeletonView(),
    };
  }
}
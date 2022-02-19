import '../home/home_view.dart';
import '../map/map_view.dart';
import 'package:flutter/material.dart';

class SkeletonModel {
  final List<Widget> pages = const [
    HomeView(),
    MapView(),
  ];
}

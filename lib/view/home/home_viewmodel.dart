import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'home_model.dart';
import 'home_service.dart';

class HomeViewModel extends ChangeNotifier {
  final String _baseUrl = 'https://www.mertkose.net/api/son-depremler/';
  late final HomeService _homeService =
      HomeService(Dio(BaseOptions(baseUrl: _baseUrl)));

  HomeModel? _earthquakes;
  HomeModel? get earthquakes => _earthquakes;

  int counter = 0;

  getEarthquakes() async {
    final response = await _homeService.getEarthquakes();
    _earthquakes = response;
    notifyListeners();
  }

  Data? findTheLargest() {
    if (earthquakes != null) {
      double largest = 0;
      Data dataClass = Data();
      for (var data in earthquakes!.data!) {
        if (double.parse(data.m!.trim()) > largest) {
          dataClass = data;
          largest = double.parse(data.m!.trim());
        }
      }
      return dataClass;
    }
    return null;
  }

  String titleChooser(int index) {
    if (earthquakes != null) {
      if (earthquakes!.data![index].district!.trim() == '-') {
        return earthquakes!.data![index].other!;
      } else {
        return earthquakes!.data![index].district! +
            ' (' +
            earthquakes!.data![index].city! +
            ')';
      }
    }
    return '-----';
  }
}

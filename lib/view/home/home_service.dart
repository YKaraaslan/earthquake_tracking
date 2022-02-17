import 'dart:io';

import 'package:dio/dio.dart';

import 'home_model.dart';

abstract class IHomeService {
  final String path = '?lastday=10';
  final Dio dio;
  IHomeService(this.dio);

  HomeModel _earthquake = HomeModel();

  Future<HomeModel?> getEarthquakes();
}

class HomeService extends IHomeService {
  HomeService(Dio dio) : super(dio);

  @override
  Future<HomeModel?> getEarthquakes() async {
    final response = await dio.get(path);
    if (response.statusCode == HttpStatus.ok) {
      _earthquake = HomeModel.fromJson(response.data);
      return _earthquake;
    }
    return null;
  }
}

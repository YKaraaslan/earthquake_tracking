import 'dart:io';

import 'package:dio/dio.dart';

import 'home_model.dart';

abstract class IHomeService {
  //final String path = '?lastday=10';
  final String path = '';
  final Dio dio;
  IHomeService(this.dio);

  late List<HomeModel>? _earthquake;
  Future<List<HomeModel>?> getEarthquakes();
}

class HomeService extends IHomeService {
  HomeService(Dio dio) : super(dio);

  @override
  Future<List<HomeModel>?> getEarthquakes() async {
    final response = await dio.get(path);
    if (response.statusCode == HttpStatus.ok) {
      _earthquake = HomeResponseModel.fromJson(response.data).data!.toList();
      return _earthquake;
    }
    return [];
  }
}

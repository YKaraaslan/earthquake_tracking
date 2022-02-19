import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earthquake/core/init/network/network_model.dart';

abstract class INetworkManager {
  final String _baseUrl = 'https://www.mertkose.net/api/son-depremler/';
  final String _path = '';
  INetworkManager();

  late List<NetworkModel>? _earthquake;
  Future<List<NetworkModel>?> getEarthquakes();
}

class NetworkManager extends INetworkManager {
  @override
  Future<List<NetworkModel>?> getEarthquakes() async {
    final response = await Dio(BaseOptions(baseUrl: _baseUrl)).get(_path);
    if (response.statusCode == HttpStatus.ok) {
      _earthquake = NetworkResponseModel.fromJson(response.data).data!.toList();
      return _earthquake;
    }
    return [];
  }
}
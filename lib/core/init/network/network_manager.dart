import 'package:dio/dio.dart';

abstract class INetworkManager {
  //final String _baseUrl = 'https://www.mertkose.net/api/son-depremler/';
  final Dio dio;
  INetworkManager(this.dio);
}

class NetworkManager extends INetworkManager {
  NetworkManager(Dio dio) : super(dio);
}
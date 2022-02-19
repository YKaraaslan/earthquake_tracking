import '../../core/init/network/network_model.dart';

class DetailsLatLongModel {
  double? lat;
  double? lon;
  double? m;
  String? city;
  String? depth;
  String? time;

  DetailsLatLongModel({this.lat, this.lon, this.m, this.city, this.depth, this.time});
}

class DetailsModel extends NetworkModel {}

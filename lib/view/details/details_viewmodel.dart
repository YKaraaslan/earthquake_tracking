import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsViewModel extends ChangeNotifier {
  late GoogleMapController controller;

  late double _lat;
  late double _lon;

  double get lat => _lat;
  double get lon => _lon;

  late LatLng latlon = LatLng(lat, lon);

  void setCoordinates(double? lats, double? lons) {
    lats == null ? _lat = 38 : _lat = lats;
    lons == null ? _lon = 35 : _lon = lons;
    notifyListeners();
  }
}

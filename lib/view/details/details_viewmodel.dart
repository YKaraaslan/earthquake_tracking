import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class DetailsViewModel extends ChangeNotifier {
  double _lat = 38;
  double _lon = 35;

  double get lat => _lat;
  double get lon => _lon;

  late LatLng latlon = LatLng(lat, lon);

  void setLatLon() {
    latlon = LatLng(lat, lon);
    notifyListeners();
  }

  void setCoordinates(double? lats, double? lons) {
    lats == null ? _lat = 38 : _lat = lats;
    lons == null ? _lon = 35 : _lon = lons;
    notifyListeners();
  }
}

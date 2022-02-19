import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetailsViewModel extends ChangeNotifier {
  double _lat = 38;
  double _lon = 35;

  double get lat => _lat;
  double get lon => _lon;

  late LatLng latlon = LatLng(lat, lon);

  late List<Marker> markers;

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void setCoordinates(double? lats, double? lons, double? m) {
    lats == null ? _lat = 38 : _lat = lats;
    lons == null ? _lon = 35 : _lon = lons;
    latlon = LatLng(lat, lon);
    markers = [];
    markers.add(markerCustom(m!, latlon));
    notifyListeners();
  }

  void changeVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  Marker markerCustom(double m, LatLng latlong) {
    Color colorMarker = Colors.blueAccent;
    if (m >= 7) {
      colorMarker = const Color.fromARGB(255, 255, 0, 0);
    } else if (m >= 6) {
      colorMarker = const Color.fromARGB(255, 255, 50, 69);
    } else if (m >= 5) {
      colorMarker = const Color.fromARGB(255, 255, 100, 0);
    } else if (m >= 4) {
      colorMarker = Colors.orange;
    } else if (m >= 3) {
      colorMarker = const Color.fromARGB(255, 255, 230, 0);
    } else if (m >= 2) {
      colorMarker = const Color.fromARGB(255, 0, 200, 255);
    } else if (m >= 1) {
      colorMarker = const Color.fromARGB(255, 0, 150, 255);
    } else {
      colorMarker = const Color.fromARGB(255, 0, 100, 255);
    }

    return Marker(
      width: m * 10,
      height: m * 10,
      point: latlong,
      builder: (ctx) => CircleAvatar(
        backgroundColor: Colors.purple,
        radius: m * 10,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: CircleAvatar(
            backgroundColor: colorMarker,
          ),
        ),
      ),
    );
  }
}

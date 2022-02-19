import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/init/network/network_manager.dart';
import '../../core/init/network/network_model.dart';

class MapViewModel extends ChangeNotifier {
  late final NetworkManager _networkManager = NetworkManager();

  List<NetworkModel>? _earthquakes;
  List<NetworkModel>? get earthquakes => _earthquakes;

  late List<Marker> markers = [];

  getEarthquakes() async {
    _earthquakes = await _networkManager.getEarthquakes();
    bringMarkers();
    notifyListeners();
  }

  void bringMarkers() {
    if (earthquakes != null) {
      for (var data in earthquakes!) {
        markers.add(markerCustom(double.parse(data.m!.trim()), LatLng(double.parse(data.lat!.trim()), double.parse(data.lon!.trim()))));
      }
    }
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
      width: m * 5,
      height: m * 5,
      point: latlong,
      builder: (ctx) => CircleAvatar(
        backgroundColor: colorMarker,
      ),
    );
  }
}

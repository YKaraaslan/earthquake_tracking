import 'package:earthquake/core/base/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'map_viewmodel.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _viewModel = context.read<MapViewModel>();
      _viewModel
        ..getEarthquakes()
        ..bringMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => Consumer(
        builder: (context, MapViewModel viewModel, child) => FlutterMap(
          options: MapOptions(
              center: LatLng(38, 35),
              zoom: 4.7,),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return const Text("© Yunus Karaaslan");
              },
            ),
            MarkerLayerOptions(rotate: false, markers: viewModel.markers),
          ],
        ),
      ),
    );
  }
}

import 'package:earthquake/core/widgets/list_tile.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/base/view/base_view.dart';
import 'details_model.dart';
import 'details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late final DetailsViewModel viewModel;
  late final DetailsLatLongModel model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      viewModel = context.read<DetailsViewModel>();
      model = ModalRoute.of(context)!.settings.arguments as DetailsLatLongModel;
      viewModel.setCoordinates(model.lat, model.lon, model.m);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: AppBar(
        title: const Text('Deprem Bilgisi'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                child: Text('Paylaş'),
              ),
            ],
          )
        ],
      ),
      onPageBuilder: (context, value) => const _DetailsBody(),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailsLatLongModel model =
        ModalRoute.of(context)!.settings.arguments as DetailsLatLongModel;

    return Stack(
      children: [
        const MapWidget(),
        Consumer(
          builder: (context, DetailsViewModel viewModel, child) =>
              AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: viewModel.isVisible ? 1 : 0,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: AnimatedContainer(
                    height: viewModel.isVisible ? 95 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                CustomListTile(
                                  value: model.m!.toString(),
                                  title: model.city!,
                                  subtitle: model.depth!,
                                  time: model.time!,
                                  fun: () => true,
                                  iconData: Icons.share_location_sharp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailsLatLongModel model =
        ModalRoute.of(context)!.settings.arguments as DetailsLatLongModel;
    return Consumer(
      builder: (context, DetailsViewModel viewModel, child) => FlutterMap(
        options: MapOptions(
          onTap: (position, latlon) {
            viewModel.changeVisibility();
          },
          center: LatLng(model.lat!, model.lon!),
          zoom: 7,
        ),
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
    );
  }
}

import 'package:flutter_map/flutter_map.dart';

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
      viewModel.setCoordinates(model.lat, model.lon);
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
    return Consumer(
      builder: (context, DetailsViewModel viewModel, child) => FlutterMap(
        options: MapOptions(
          center: viewModel.latlon,
          zoom: 8,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text("© Yunus Karaaslan");
            },
          ),
          MarkerLayerOptions(
            rotate: false,
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: viewModel.latlon,
                builder: (ctx) => const FlutterLogo(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

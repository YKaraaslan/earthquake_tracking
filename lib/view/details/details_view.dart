import '../../core/base/view/base_view.dart';
import 'details_model.dart';
import 'details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late final DetailsViewModel viewModel;
  late final DetailsModel model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      viewModel = context.read<DetailsViewModel>();
      model = ModalRoute.of(context)!.settings.arguments as DetailsModel;
      viewModel.setCoordinates(model.lat, model.lon);
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.controller.dispose();
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
      builder: (context, DetailsViewModel viewModel, child) => GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: viewModel.latlon,
          zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          viewModel.controller = controller;
          viewModel.setLatLon();
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: viewModel.latlon,
            zoom: 10,
          )));
        },
        markers: {
          Marker(
              markerId: const MarkerId('origin'),
              infoWindow: const InfoWindow(title: 'Deprem Bölgesi'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange),
              position: viewModel.latlon),
        },
      ),
    );
  }
}

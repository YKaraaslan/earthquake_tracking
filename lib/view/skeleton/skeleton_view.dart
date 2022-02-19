import '../../core/base/view/base_view.dart';
import '../home/home_view.dart';
import '../map/map_view.dart';
import 'skeleton_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkeletonView extends StatelessWidget {
  const SkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SkeletonViewModel>();
    return Consumer(
      builder: (context, SkeletonViewModel viewModel, child) => BaseView(
        onPageBuilder: (context, value) {
          switch (viewModel.index) {
            case 0:
              return const HomeView();
            default:
              return const MapView();
          }
        },
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.warning), label: 'Ana Sayfa'),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_sharp), label: 'Ana Sayfa'),
          ],
          onTap: (index) {
            viewModel.setIndex(index);
          },
        ),
      ),
    );
  }
}

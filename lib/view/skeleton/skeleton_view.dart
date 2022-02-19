import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/base/view/base_view.dart';
import 'skeleton_viewmodel.dart';

class SkeletonView extends StatelessWidget {
  const SkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SkeletonViewModel>();
    return Consumer(
      builder: (context, SkeletonViewModel viewModel, child) => BaseView(
        onPageBuilder: (context, value) => viewModel.setPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: viewModel.index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.warning), label: 'Ana Sayfa'),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_sharp), label: 'Harita'),
          ],
          onTap: (index) {
            viewModel.setIndex(index);
          },
        ),
      ),
    );
  }
}

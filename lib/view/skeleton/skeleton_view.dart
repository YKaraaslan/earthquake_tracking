import 'package:earthquake/core/base/view/base_view.dart';
import 'package:flutter/material.dart';

class SkeletonView extends StatelessWidget {
  const SkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) {
        return Container();
      },
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Ana Sayfa'),
        ],
      ),
    );
  }
}

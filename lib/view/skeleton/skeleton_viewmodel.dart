import 'skeleton.model.dart';
import 'package:flutter/material.dart';

class SkeletonViewModel extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  SkeletonModel model = SkeletonModel();

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  Widget setPage() {
    return model.pages[index];
  }
}

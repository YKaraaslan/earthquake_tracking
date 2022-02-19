import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/constant/sizes.dart';
import 'home_model.dart';
import 'home_service.dart';

class HomeViewModel extends ChangeNotifier {
  final String _baseUrl = 'https://www.mertkose.net/api/son-depremler/';
  late final HomeService _homeService =
      HomeService(Dio(BaseOptions(baseUrl: _baseUrl)));

  List<HomeModel>? _earthquakes;
  List<HomeModel>? get earthquakes => _earthquakes;

  List<HomeModel>? _earthquakesForSelections;
  List<HomeModel>? get earthquakesForSelections => _earthquakesForSelections;

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  late TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  int _itemCounter = 10;
  int get itemCounter => _itemCounter;

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final EdgeInsets _animatedContainerMargin = const EdgeInsets.only(top: 0);
  EdgeInsets get animatedContainerMargin => _animatedContainerMargin;

  bool _isFocused = false;
  bool get isFocused => _isFocused;

  void setItemCounter(int value) {
    _isVisible = true;
    _itemCounter = itemCounter + value;
    _isVisible = false;
    notifyListeners();
  }

  getEarthquakes() async {
    _earthquakes = await _homeService.getEarthquakes();
    _earthquakesForSelections = _earthquakes;
    notifyListeners();
  }

  HomeModel? findTheLargest() {
    if (earthquakes != null) {
      double largest = 0;
      HomeModel dataClass = HomeModel();
      for (var data in _earthquakes!) {
        if (double.parse(data.m!.trim()) > largest) {
          dataClass = data;
          largest = double.parse(data.m!.trim());
        }
      }
      return dataClass;
    }
    return null;
  }

  String titleChooser(int index) {
    if (_earthquakesForSelections != null) {
      if (_earthquakesForSelections![index].district!.trim() == '-') {
        return _earthquakesForSelections![index].other!;
      } else {
        return _earthquakesForSelections![index].district! +
            ' (' +
            _earthquakesForSelections![index].city! +
            ')';
      }
    }
    return '-----';
  }

  void fun(BuildContext context, int index, bool? all) {
    if (earthquakes != null) {
      if (all != null) {
        _earthquakesForSelections = _earthquakes;
      } else {
        try {
          _earthquakesForSelections = earthquakes!
              .where((element) => double.parse(element.m!) >= index)
              .toList();
        } catch (e) {
          _earthquakesForSelections = [];
        }
      }
      setText(context);
      notifyListeners();
    }
  }

  void bringResults(String value) {
    if (earthquakes != null) {
      _earthquakesForSelections = [];
      if (value.isEmpty) {
        _earthquakesForSelections = _earthquakes;
      } else {
        try {
          _earthquakesForSelections = earthquakes!
              .where((element) => element.city!.toLowerCase().contains(value))
              .toList();
        } catch (e) {
          _earthquakesForSelections = [];
        }
      }
      notifyListeners();
    }
  }

  void showMaterialDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  void setText(BuildContext context) {
    FocusScope.of(context).unfocus();
    textEditingController.clear();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  EdgeInsets changeMargin(BuildContext context) {
    if (isFocused) {
      return const EdgeInsets.only(top: 0);
    } else {
      return EdgeInsets.only(top: Sizes.height_25percent(context));
    }
  }

  void setControllers() {
    _textEditingController = TextEditingController();
  }
}

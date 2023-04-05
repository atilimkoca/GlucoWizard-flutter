import 'package:flutter/material.dart';

class HealtPageProvider extends ChangeNotifier {
  double? _initialPage = 0;
  int get initialPage => _initialPage!.toInt();
  set setinitialPage(double value) {
    _initialPage = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../services/tracking_chart_service.dart';

class LoginPageProvider extends ChangeNotifier {
  // Path: lib\providers\login_provider.dart
  // Compare this snippet from lib\providers\login_provider.dart:
  // import 'package:flutter/material.dart';
  //
  // class LoginProvider extends ChangeNotifier {
  //   bool _isLogin = false;
  //   bool get isLogin => _isLogin;
  //
  //   void setLogin(bool value) {
  //     _isLogin = value;
  //     notifyListeners();
  //   }
  // }
  final _service = TrackingChartService();
  List _users = [];
  List get users => _users;
  // Future<void> addUser() async {
  //   _users = await _service.addTrackingChart();

  //   notifyListeners();
  // }
  bool _offline = false;
  bool get offline => _offline;
  void setOffline(bool value) {
    _offline = value;
    notifyListeners();
  }

  String? _userId;
  String? get userId => _userId;
  void setUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  bool? _isLogin = false;
  bool? get isLogin => _isLogin;

  void setLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}

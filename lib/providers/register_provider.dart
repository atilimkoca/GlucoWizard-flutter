import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/services/register_service.dart';

import '../services/tracking_chart_service.dart';

class RegisterPageProvider extends ChangeNotifier {
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
  final _trackingService = TrackingChartService();
  final _registerService = RegisterService();
  List _users = [];
  List get users => _users;
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

  Future<void> addUser(String uid) async {
    _users = await _registerService.addUser(uid);

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/services/tracking_chart_service.dart';

class TrackingChartProvider extends ChangeNotifier {
  final _service = TrackingChartService();
  List _users = [];
  List get users => _users;
  Future<void> addTrackingChart(String uid, DateTime date, String value) async {
    _users = await _service.addTrackingChart(uid, date, value);

    notifyListeners();
  }
  // Future<void> getTrackingChart(String uid, DateTime date) async {
  //   _users = await _service.addTrackingChart(uid, date);

  //   notifyListeners();
  // }
  Future<void> getTrackingChart(String uid, String date) async {
    _users = await _service.getTrackingChart(uid, date);

    notifyListeners();
  }
}

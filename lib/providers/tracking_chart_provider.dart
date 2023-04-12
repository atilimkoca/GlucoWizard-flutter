import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';
import 'package:glucowizard_flutter/services/tracking_chart_service.dart';

class TrackingChartProvider extends ChangeNotifier {
  final _service = TrackingChartService();
  List _trackingCharts = [];
  List get trackingCharts => _trackingCharts;
  Future<void> addTrackingChart(TrackingChart chart) async {
    await _service.addTrackingChart(chart);
    getTrackingChart(chart);
    notifyListeners();
  }
  // Future<void> getTrackingChart(String uid, DateTime date) async {
  //   _users = await _service.addTrackingChart(uid, date);

  //   notifyListeners();
  // }
  Future<void> getTrackingChart(TrackingChart chart) async {
    _trackingCharts = await _service.getTrackingChart(chart);

    notifyListeners();
  }
}

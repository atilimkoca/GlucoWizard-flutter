import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';
import 'package:glucowizard_flutter/services/tracking_chart_service.dart';

class TrackingChartProvider extends ChangeNotifier {
  final _service = TrackingChartService();
  List _trackingCharts = [];
  List get trackingCharts => _trackingCharts;
  bool? _checkboxValue = true;
  bool? get checkboxValue => _checkboxValue;
  String? _currentDate;
  String? get currentDate => _currentDate;
  String? _currentHour;
  String? get currentHour => _currentHour;
  void setCurrentHour(String value) {
    _currentHour = value;
    notifyListeners();
  }

  void setCurrentDate(String value) {
    _currentDate = value;
    notifyListeners();
  }

  setcheckboxValue(bool? value) {
    _checkboxValue = value;
    notifyListeners();
  }

  Future<void> addTrackingChart(TrackingChart chart, bool checkboxValue) async {
    await _service.addTrackingChart(chart, checkboxValue);
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

  Future<void> updateTrackingChart(TrackingChart chart) async {
    await _service.updateTrackingChart(chart);
    getTrackingChart(chart);
    notifyListeners();
  }

  Future<void> deleteTrackingChart(TrackingChart chart) async {
    await _service.deleteTrackingChart(chart);
    getTrackingChart(chart);
    notifyListeners();
  }
}

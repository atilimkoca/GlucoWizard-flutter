import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/tracking_chart_model.dart';

class TrackingChartService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addTrackingChart(TrackingChart chart) async {
    var date = DateTime.now();
    var formatter2 = DateFormat('yyyy-MM-dd', 'tr_TR');
    var formatter = DateFormat('hh:mm:ss', 'tr_TR');
    formatter2.format(date);
    formatter.format(date);
    String formattedDate = formatter.format(date);
    String formattedDate2 = formatter2.format(date);
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser['alarms'] = 'test';
    _eklenecekUser['trackingChart'] = {
      formattedDate2: {formattedDate: chart.glucoseLevel}
    };

    await _firestore
        .doc('users/${chart.uid}')
        .set(_eklenecekUser, SetOptions(merge: true));
    return chart;
  }

  getTrackingChart(TrackingChart chart) async {
    List<TrackingChart> _charts = [];
    try {
      var response = await _firestore.doc('users/${chart.uid}').get();

      for (var data in response.data()!['trackingChart'][chart.date].keys) {
        //TrackingChart _chart = TrackingChart.toMap(data);
        _charts.add(TrackingChart(
          date: chart.date,
          uid: chart.uid,
          hour: data,
          glucoseLevel: response.data()!['trackingChart'][chart.date][data],
        ));
      }
    } catch (e) {}

    return _charts;
  }
}

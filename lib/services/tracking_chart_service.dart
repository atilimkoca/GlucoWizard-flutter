import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/tracking_chart_model.dart';
import '../providers/tracking_chart_provider.dart';

class TrackingChartService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addTrackingChart(TrackingChart chart, bool checkboxValue) async {
    var date = DateTime.now();
    var formatter2 = DateFormat('yyyy-MM-dd', 'tr_TR');

    var formatter = DateFormat.Hm();
    String formattedDate = '';
    String formattedDate2 = '';
    formatter2.format(date);
    if (checkboxValue == true) {
      formattedDate = formatter.format(date);
    } else {
      formattedDate = chart.hour!;
    }
    if (chart.date == null) {
      chart.date = formatter2.format(date);
    }

    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};

    _eklenecekUser['trackingChart'] = {
      chart.date: {formattedDate: chart.glucoseLevel}
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

  updateTrackingChart(TrackingChart chart) async {
    await _firestore.doc('users/${chart.uid}').update(
        {'trackingChart.${chart.date}.${chart.hour}': chart.glucoseLevel});
  }

  deleteTrackingChart(TrackingChart chart) async {
    await _firestore.doc('users/${chart.uid}').update(
        {'trackingChart.${chart.date}.${chart.hour}': FieldValue.delete()});
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glucowizard_flutter/models/gradient_colors.dart';
import 'package:intl/intl.dart';

import '../models/alarm_info.dart';
import '../models/tracking_chart_model.dart';
import '../providers/tracking_chart_provider.dart';

class AlarmsService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addAlarm(String uid, AlarmInfo alarmInfo, int totalId) async {
    var date = DateTime.now();
    var formatter2 = DateFormat('yyyy-MM-dd', 'tr_TR');

    var formatter = DateFormat.Hm();
    String formattedDate = '';
    String formattedDate2 = '';
    formatter2.format(date);

    Map<String, dynamic> _alarms = <String, dynamic>{};

    _alarms['alarms'] = {
      alarmInfo.alarmTitle ?? '': {alarmInfo.alarmId, alarmInfo.alarmDateTime}
    };

    Map<String, dynamic> _totalId = <String, dynamic>{};
    _totalId['totalId'] = totalId;

    await _firestore.doc('users/$uid').set(_totalId, SetOptions(merge: true));

    await _firestore.doc('users/$uid').set(_alarms, SetOptions(merge: true));
  }

  getAlarms(String uid) async {
    List<AlarmInfo> _alarms = [];
    try {
      var response = await _firestore.doc('users/$uid').get();

      for (var data in response.data()!['alarms'].keys) {
        _alarms.add(AlarmInfo(
            alarmDateTime: DateTime.fromMillisecondsSinceEpoch(
                response.data()!['alarms'][data][1].millisecondsSinceEpoch),
            alarmId: response.data()!['alarms'][data][0],
            alarmTitle: data.toString(),
            gradientColors: GradientColors.sky));
      }
    } catch (e) {}

    return _alarms;
  }

  deleteAlarm(String uid, AlarmInfo alarmInfo) async {
    await _firestore
        .doc('users/$uid')
        .update({'alarms.${alarmInfo.alarmTitle}': FieldValue.delete()});
  }
}

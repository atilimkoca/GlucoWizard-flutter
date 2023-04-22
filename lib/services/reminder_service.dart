import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glucowizard_flutter/models/gradient_colors.dart';
import 'package:intl/intl.dart';

import '../models/alarm_info.dart';
import '../models/reminder_model.dart';
import '../models/tracking_chart_model.dart';
import '../providers/tracking_chart_provider.dart';

class ReminderService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addReminder(String uid, ReminderModel reminder, int totalId) async {
    var date = DateTime.now();
    var formatter2 = DateFormat('yyyy-MM-dd', 'tr_TR');

    var formatter = DateFormat.Hm();
    String formattedDate = '';
    String formattedDate2 = '';
    formatter2.format(date);

    Map<String, dynamic> _reminders = <String, dynamic>{};

    _reminders['reminders'] = {
      reminder.alarmTitle ?? '': {
        reminder.alarmId,
        reminder.alarmDateTime,
      }
    };

    Map<String, dynamic> _totalId = <String, dynamic>{};
    _totalId['totalId'] = totalId;

    await _firestore.doc('users/$uid').set(_totalId, SetOptions(merge: true));

    await _firestore.doc('users/$uid').set(_reminders, SetOptions(merge: true));
  }

  getReminders(String uid) async {
    List<ReminderModel> _reminders = [];
    try {
      var response = await _firestore.doc('users/$uid').get();

      for (var data in response.data()!['reminders'].keys) {
        _reminders.add(ReminderModel(
          alarmDateTime: DateTime.fromMillisecondsSinceEpoch(
              response.data()!['reminders'][data][1].millisecondsSinceEpoch),
          alarmId: response.data()!['reminders'][data][0],
          alarmTitle: data.toString(),
          gradientColors: GradientColors.sky,
        ));
      }
    } catch (e) {}

    return _reminders;
  }

  deleteAlarm(String uid, ReminderModel reminder) async {
    await _firestore
        .doc('users/$uid')
        .update({'reminders.${reminder.alarmTitle}': FieldValue.delete()});
  }
}

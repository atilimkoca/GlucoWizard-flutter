import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glucowizard_flutter/models/alarm_info.dart';
import 'package:glucowizard_flutter/services/alarms_service.dart';
import 'package:glucowizard_flutter/services/reminder_service.dart';

import '../models/reminder_model.dart';

class ReminderProvider extends ChangeNotifier {
  ReminderService _service = ReminderService();
  bool? _status = false;
  bool get status => _status!;
  void setStatus(bool index) {
    _status = index;
    notifyListeners();
  }

  int? random;
  int? _alarmId = 1;
  int get alarmId => _alarmId!;
  void setAlarmId(int index) {
    _alarmId = index + 1;
    notifyListeners();
  }

  List<ReminderModel>? _reminder;
  List<ReminderModel>? get reminder => _reminder ?? [];
  // void setAlarmInfo(AlarmInfo index) {
  //   _alarmInfo = index;
  //   notifyListeners();
  // }

  addReminder(String uid, ReminderModel reminder, int totalId) async {
    await _service.addReminder(uid, reminder, totalId);
    getReminders(uid);
    notifyListeners();
  }

  getReminders(String uid) async {
    _reminder = await _service.getReminders(uid);

    notifyListeners();
  }

  deleteAlarm(String uid, ReminderModel reminder) async {
    await _service.deleteAlarm(uid, reminder);
    getReminders(uid);
    notifyListeners();
  }

  int? _currentTabIndex;
  int? get currentTabIndex => _currentTabIndex;
  void setCurrentTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}

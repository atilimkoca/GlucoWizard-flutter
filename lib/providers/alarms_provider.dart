import 'package:flutter/material.dart';

import 'package:glucowizard_flutter/models/alarm_info.dart';
import 'package:glucowizard_flutter/services/alarms_service.dart';

class AlarmsProvider extends ChangeNotifier {
  AlarmsService _service = AlarmsService();
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

  List<AlarmInfo>? _alarmInfo;
  List<AlarmInfo>? get alarmInfo => _alarmInfo ?? [];
  // void setAlarmInfo(AlarmInfo index) {
  //   _alarmInfo = index;
  //   notifyListeners();
  // }

  addAlarms(String uid, AlarmInfo alarmInfo, int totalId) async {
    await _service.addAlarm(uid, alarmInfo, totalId);
    getAlarms(uid);
    notifyListeners();
  }

  getAlarms(String uid) async {
    _alarmInfo = await _service.getAlarms(uid);

    notifyListeners();
  }

  int? _totalId;
  int? get totalId => _totalId;
  void setTotalId(int index) {
    _totalId = index + 1;
    notifyListeners();
  }

  deleteAlarm(String uid, AlarmInfo alarmInfo) async {
    await _service.deleteAlarm(uid, alarmInfo);
    getAlarms(uid);
    notifyListeners();
  }
}

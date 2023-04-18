import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlarmsProvider extends ChangeNotifier {
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
}

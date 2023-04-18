import 'package:flutter/material.dart';

class AlarmInfo {
  int? alarmId;
  DateTime alarmDateTime;
  String? alarmTitle;
  bool? isActive;
  List<Color>? gradientColors;
  AlarmInfo(this.alarmDateTime,
      {this.alarmTitle, this.gradientColors, this.alarmId, this.isActive});
}

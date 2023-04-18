import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  DateTime? alarmTime;
  bool? onOff;

  ReminderModel({this.alarmTime, this.onOff});

  Map<String, dynamic> toMap() {
    return {'time': alarmTime, 'onOff': onOff};
  }

  factory ReminderModel.fromMap(map) {
    return ReminderModel(alarmTime: map['time'], onOff: map['onOff']);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlarmInfo {
  int? alarmId;
  DateTime? alarmDateTime;
  String? alarmTitle;
  bool? isRepeating;
  List<Color>? gradientColors;
  int? totalId;
  AlarmInfo({
    this.alarmId,
    this.alarmDateTime,
    this.alarmTitle,
    this.isRepeating,
    this.gradientColors,
    this.totalId,
  });

  AlarmInfo copyWith({
    int? alarmId,
    DateTime? alarmDateTime,
    String? alarmTitle,
    bool? isRepeating,
    List<Color>? gradientColors,
    int? totalId,
  }) {
    return AlarmInfo(
      alarmId: alarmId ?? this.alarmId,
      alarmDateTime: alarmDateTime ?? this.alarmDateTime,
      alarmTitle: alarmTitle ?? this.alarmTitle,
      isRepeating: isRepeating ?? this.isRepeating,
      gradientColors: gradientColors ?? this.gradientColors,
      totalId: totalId ?? this.totalId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'alarmId': alarmId,
      'alarmDateTime': alarmDateTime?.millisecondsSinceEpoch,
      'alarmTitle': alarmTitle,
      'isRepeating': isRepeating,
      'gradientColors': gradientColors!.map((x) => x.value).toList(),
      'totalId': totalId,
    };
  }

  factory AlarmInfo.fromMap(Map<String, dynamic> map) {
    return AlarmInfo(
      alarmId: map['alarmId'] != null ? map['alarmId'] as int : null,
      alarmDateTime: map['alarmDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['alarmDateTime'] as int)
          : null,
      alarmTitle:
          map['alarmTitle'] != null ? map['alarmTitle'] as String : null,
      isRepeating:
          map['isRepeating'] != null ? map['isRepeating'] as bool : null,
      gradientColors: map['gradientColors'] != null
          ? List<Color>.from(
              (map['gradientColors'] as List<int>).map<Color?>(
                (x) => Color(x),
              ),
            )
          : null,
      totalId: map['totalId'] != null ? map['totalId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlarmInfo.fromJson(String source) =>
      AlarmInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlarmInfo(alarmId: $alarmId, alarmDateTime: $alarmDateTime, alarmTitle: $alarmTitle, isRepeating: $isRepeating, gradientColors: $gradientColors, totalId: $totalId)';
  }

  @override
  bool operator ==(covariant AlarmInfo other) {
    if (identical(this, other)) return true;

    return other.alarmId == alarmId &&
        other.alarmDateTime == alarmDateTime &&
        other.alarmTitle == alarmTitle &&
        other.isRepeating == isRepeating &&
        listEquals(other.gradientColors, gradientColors) &&
        other.totalId == totalId;
  }

  @override
  int get hashCode {
    return alarmId.hashCode ^
        alarmDateTime.hashCode ^
        alarmTitle.hashCode ^
        isRepeating.hashCode ^
        gradientColors.hashCode ^
        totalId.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrackingChart {
  String? uid;
  String? date;
  String? glucoseLevel;
  String? hour;
  TrackingChart({
    this.uid,
    this.date,
    this.glucoseLevel,
    this.hour,
  });

  TrackingChart copyWith({
    String? uid,
    String? date,
    String? glucoseLevel,
    String? hour,
  }) {
    return TrackingChart(
      uid: uid ?? this.uid,
      date: date ?? this.date,
      glucoseLevel: glucoseLevel ?? this.glucoseLevel,
      hour: hour ?? this.hour,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'date': date,
      'glucoseLevel': glucoseLevel,
      'hour': hour,
    };
  }

  factory TrackingChart.fromMap(Map<String, dynamic> map) {
    return TrackingChart(
      uid: map['uid'] != null ? map['uid'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      glucoseLevel:
          map['glucoseLevel'] != null ? map['glucoseLevel'] as String : null,
      hour: map['hour'] != null ? map['hour'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackingChart.fromJson(String source) =>
      TrackingChart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrackingChart(uid: $uid, date: $date, glucoseLevel: $glucoseLevel, hour: $hour)';
  }

  @override
  bool operator ==(covariant TrackingChart other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.date == date &&
        other.glucoseLevel == glucoseLevel &&
        other.hour == hour;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ date.hashCode ^ glucoseLevel.hashCode ^ hour.hashCode;
  }
}

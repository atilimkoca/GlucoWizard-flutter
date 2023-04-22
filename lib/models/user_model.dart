// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:glucowizard_flutter/models/alarm_info.dart';
import 'package:glucowizard_flutter/models/reminder_model.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';

import '../components/reminder.dart';

class UserModel {
  String? id;
  String? name;
  String? surname;
  String? height;
  String? weight;
  String? gender;
  String? age;
  String? email;
  String? image;
  TrackingChart? trackingChart;
  String? water;
  DateTime? time;
  int? steps;
  int? counter;
  AlarmInfo? alarmInfo;
  int? totalId;
  int? pastSteps;
  ReminderModel? reminders;
  UserModel({
    this.id,
    this.name,
    this.surname,
    this.height,
    this.weight,
    this.gender,
    this.age,
    this.email,
    this.image,
    this.trackingChart,
    this.water,
    this.time,
    this.steps,
    this.counter,
    this.alarmInfo,
    this.totalId,
    this.pastSteps,
    this.reminders,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? surname,
    String? height,
    String? weight,
    String? gender,
    String? age,
    String? email,
    String? image,
    TrackingChart? trackingChart,
    String? water,
    DateTime? time,
    int? steps,
    int? counter,
    AlarmInfo? alarmInfo,
    int? totalId,
    int? pastSteps,
    ReminderModel? reminders,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      email: email ?? this.email,
      image: image ?? this.image,
      trackingChart: trackingChart ?? this.trackingChart,
      water: water ?? this.water,
      time: time ?? this.time,
      steps: steps ?? this.steps,
      counter: counter ?? this.counter,
      alarmInfo: alarmInfo ?? this.alarmInfo,
      totalId: totalId ?? this.totalId,
      pastSteps: pastSteps ?? this.pastSteps,
      reminders: reminders ?? this.reminders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'surname': surname,
      'height': height,
      'weight': weight,
      'gender': gender,
      'age': age,
      'email': email,
      'image': image,
      'trackingChart': trackingChart?.toMap(),
      'water': water,
      'time': time?.millisecondsSinceEpoch,
      'steps': steps,
      'counter': counter,
      'alarmInfo': alarmInfo?.toMap(),
      'totalId': totalId,
      'pastSteps': pastSteps,
      'reminders': reminders?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      age: map['age'] != null ? map['age'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      trackingChart: map['trackingChart'] != null
          ? TrackingChart.fromMap(map['trackingChart'] as Map<String, dynamic>)
          : null,
      water: map['water'] != null ? map['water'] as String : null,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'] as int)
          : null,
      steps: map['steps'] != null ? map['steps'] as int : null,
      counter: map['counter'] != null ? map['counter'] as int : null,
      alarmInfo: map['alarmInfo'] != null
          ? AlarmInfo.fromMap(map['alarmInfo'] as Map<String, dynamic>)
          : null,
      totalId: map['totalId'] != null ? map['totalId'] as int : null,
      pastSteps: map['pastSteps'] != null ? map['pastSteps'] as int : null,
      reminders: map['reminders'] != null
          ? ReminderModel.fromMap(map['reminders'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, surname: $surname, height: $height, weight: $weight, gender: $gender, age: $age, email: $email, image: $image, trackingChart: $trackingChart, water: $water, time: $time, steps: $steps, counter: $counter, alarmInfo: $alarmInfo, totalId: $totalId, pastSteps: $pastSteps, reminders: $reminders)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.surname == surname &&
        other.height == height &&
        other.weight == weight &&
        other.gender == gender &&
        other.age == age &&
        other.email == email &&
        other.image == image &&
        other.trackingChart == trackingChart &&
        other.water == water &&
        other.time == time &&
        other.steps == steps &&
        other.counter == counter &&
        other.alarmInfo == alarmInfo &&
        other.totalId == totalId &&
        other.pastSteps == pastSteps &&
        other.reminders == reminders;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        email.hashCode ^
        image.hashCode ^
        trackingChart.hashCode ^
        water.hashCode ^
        time.hashCode ^
        steps.hashCode ^
        counter.hashCode ^
        alarmInfo.hashCode ^
        totalId.hashCode ^
        pastSteps.hashCode ^
        reminders.hashCode;
  }
}

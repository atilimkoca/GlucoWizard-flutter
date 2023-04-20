import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glucowizard_flutter/models/user_model.dart';
import 'package:intl/intl.dart';

import '../models/tracking_chart_model.dart';
import '../providers/tracking_chart_provider.dart';

class ProfileService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getInfos(String uid) async {
    UserModel _users = UserModel();
    try {
      var response = await _firestore.doc('users/$uid').get();
      print(response.data()!['name']);
      //TrackingChart _chart = TrackingChart.toMap(data);
      //print(response.data()!);
      _users.age = response.data()!['age'];
      _users.name = response.data()!['name'];
      _users.surname = response.data()!['surname'];
      _users.height = response.data()!['height'];
      _users.weight = response.data()!['weight'];
      _users.gender = response.data()!['gender'] ?? '';
      _users.water = response.data()!['water'] ?? '0';
      _users.time = DateTime.fromMillisecondsSinceEpoch(
          response.data()!['time'].millisecondsSinceEpoch);
      _users.steps = response.data()!['steps'] ?? 0;
      _users.counter = response.data()!['counter'];
    } catch (e) {}

    return _users;
  }

  updateTrackingChart(UserModel user) async {
    await _firestore.doc('users/${user.id}').update({
      'age': user.age ?? '',
      'name': user.name ?? '',
      'surname': user.surname ?? '',
      'gender': user.gender ?? '',
      'height': user.height ?? '',
      'weight': user.weight ?? '',
    });
  }

  updateWater(String uid, String water) async {
    Map<String, dynamic> _water = <String, dynamic>{};
    _water['water'] = water;

    await _firestore.doc('users/$uid').set(_water, SetOptions(merge: true));
  }

  updateTime(String uid, DateTime time) async {
    Map<String, dynamic> _time = <String, dynamic>{};
    _time['time'] = DateTime.now();

    await _firestore.doc('users/$uid').set(_time, SetOptions(merge: true));
  }

  updateSteps(String uid, int steps) async {
    Map<String, dynamic> _steps = <String, dynamic>{};
    _steps['steps'] = steps;

    await _firestore.doc('users/$uid').set(_steps, SetOptions(merge: true));
  }

  updateCounter(String uid, int counter) async {
    Map<String, dynamic> _counter = <String, dynamic>{};
    _counter['counter'] = counter + 1;

    await _firestore.doc('users/$uid').set(_counter, SetOptions(merge: true));
  }
}

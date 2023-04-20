import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/user_model.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel _users = UserModel();
  UserModel get users => _users;
  ProfileService _profileService = ProfileService();
  String? _gender;
  String? get gender => _gender;
  double? _water;
  double? get water => _water;
  String? tempWater;
  String? _savedDay;
  String? get savedDay => _savedDay;
  String? _steps;
  String? get steps => _steps;
  int? _oldSteps;
  int? get oldSteps => _oldSteps;
  int? _newSteps;
  int? get newSteps => _newSteps;

  setOldSteps(int value) {
    _oldSteps = value;
    notifyListeners();
  }

  setNewSteps(int value) {
    _newSteps = value;
    notifyListeners();
  }

  setSteps(String value) {
    _steps = value;
    notifyListeners();
  }

  setSavedDay(String day) {
    _savedDay = day;
    notifyListeners();
  }

  setWater(double value, String uid) {
    _water = value;
    updateWater(uid);
    notifyListeners();
  }

  setGender(String index) {
    _gender = index;
    notifyListeners();
  }

  Future<void> getInfos(String uid) async {
    _users = await _profileService.getInfos(uid);
    if (_users.water == null) {
      _water = 0;
    } else {
      _water = double.parse(_users.water!);
    }
    notifyListeners();
  }

  Future<void> updateTrackingChart(UserModel user) async {
    await _profileService.updateTrackingChart(user);
    getInfos(user.id!);
    notifyListeners();
  }

  Future<void> updateWater(String uid) async {
    await _profileService.updateWater(uid, _water.toString());
    getInfos(uid);
    notifyListeners();
  }

  setWaterFirstTime(String water) {
    if (_water == null) {
      if (water == null) {
        _water = 0;
      } else {
        _water = double.parse(water);
      }
    }
  }

  //updateTime
  updateTime(String uid, DateTime time) {
    _profileService.updateTime(uid, time);
    notifyListeners();
  }

  updateSteps(String uid, int steps) {
    _profileService.updateSteps(uid, steps);
    notifyListeners();
  }

  updateCounter(String uid, int counter) {
    _profileService.updateCounter(uid, counter);
    getInfos(uid);
    notifyListeners();
  }
}

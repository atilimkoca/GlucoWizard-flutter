import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glucowizard_flutter/models/user_model.dart';

class RegisterService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel _userModel = UserModel();
  addUser(String uid) async {
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser['name'] = _userModel.name;
    _eklenecekUser['age'] = _userModel.age;
    _eklenecekUser['email'] = _userModel.email;
    _eklenecekUser['image'] = _userModel.image;
    _eklenecekUser['trackingChart'] = _userModel.trackingChart;
    _eklenecekUser['id'] = _userModel.id;

    await _firestore.collection('users').doc(uid).set(_eklenecekUser);
  }
}

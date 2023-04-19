// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:glucowizard_flutter/models/tracking_chart_model.dart';

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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, surname: $surname, height: $height, weight: $weight, gender: $gender, age: $age, email: $email, image: $image, trackingChart: $trackingChart, water: $water)';
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
        other.water == water;
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
        water.hashCode;
  }
}

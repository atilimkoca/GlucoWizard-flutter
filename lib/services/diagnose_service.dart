import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:collection/collection.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

class DiagnoseModel {
  late Interpreter _interpreter;
  Future loadModel(String text1, String text2) async {
    final interpreter = await Interpreter.fromAsset('classifier.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 6; i++) {
        sum += output[0][i];
      }
      return sum / 6;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 6; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 6);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 6; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 6; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    findOutput(List<dynamic> output) {
      var max = output[0][0];
      var index = 0;
      for (var i = 0; i < 4; i++) {
        if (output[0][i] > max) {
          max = output[0][i];
          index = i;
        }
      }

      return index;
    }

    // var mean = calculateAverage(input);
    // var standardDeviation = calculateStandatdDeviation(input);

    // input = standardalize(input, mean, standardDeviation);
    input = input.map((e) => e.map((e) => e.toDouble()).toList()).toList();
    var output = List.filled(1 * 4, 0).reshape([1, 4]);
    interpreter.run(input, output);
    var label = findOutput(output);

    //output = inverseTransform(output, mean, standardDeviation);
    print(output);
    return label;
  }

  trainModel() async {}
}

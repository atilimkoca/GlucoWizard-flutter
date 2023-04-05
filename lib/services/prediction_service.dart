import 'dart:ffi';
import 'dart:math';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:collection/collection.dart';

class PredictionModel {
  late Interpreter _interpreter;
  loadModel(String text1, String text2, String text3, String text4,
      String text5, String text6) async {
    final interpreter =
        await Interpreter.fromAsset('attention_lstm_teknofest.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
        double.parse(text3),
        double.parse(text4),
        double.parse(text5),
        double.parse(text6)
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;
      print(6);
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
      print(result);
      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 6; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }
      print(result);
      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 6, 0).reshape([1, 6]);
    interpreter.run(input, output);
    print(output);
    output = inverseTransform(output, mean, standardDeviation);
    print(output);
  }
}

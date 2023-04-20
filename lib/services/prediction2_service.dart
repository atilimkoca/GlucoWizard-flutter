import 'dart:ffi';
import 'dart:math';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:collection/collection.dart';

class PredictionTwoModel {
  late Interpreter _interpreter;
  Future load30Model(String text1, String text2) async {
    final interpreter = await Interpreter.fromAsset('thirty_2.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 2; i++) {
        sum += output[0][i];
      }
      return sum / 2;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 2; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 2);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 2; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 2; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 2, 0).reshape([1, 2]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }

  Future load15Model(
    String text1,
  ) async {
    final interpreter = await Interpreter.fromAsset('fifteen_2.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 1; i++) {
        sum += output[0][i];
      }
      return sum / 1;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 1; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 1);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 1; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 1; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }

  Future load45Model(
    String text1,
    String text2,
    String text3,
  ) async {
    final interpreter = await Interpreter.fromAsset('fourty_2.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
        double.parse(text3),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 3; i++) {
        sum += output[0][i];
      }
      return sum / 3;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 3; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 3);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 3; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 3; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 3, 0).reshape([1, 3]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }

  Future load60Model(
    String text1,
    String text2,
    String text3,
    String text4,
  ) async {
    final interpreter = await Interpreter.fromAsset('sixty_2.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
        double.parse(text3),
        double.parse(text4),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 4; i++) {
        sum += output[0][i];
      }
      return sum / 4;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 4; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 4);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 4; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 4; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 4, 0).reshape([1, 4]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }

  Future load90Model(
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
  ) async {
    final interpreter = await Interpreter.fromAsset('ninety_min.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
        double.parse(text3),
        double.parse(text4),
        double.parse(text5),
        double.parse(text6),
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

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 6, 0).reshape([1, 6]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }

  Future load120Model(
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
    String text7,
    String text8,
  ) async {
    final interpreter =
        await Interpreter.fromAsset('attention_lstm_teknofest.tflite');
    List<List<double>> input = [
      [
        double.parse(text1),
        double.parse(text2),
        double.parse(text3),
        double.parse(text4),
        double.parse(text5),
        double.parse(text6),
        double.parse(text7),
        double.parse(text8),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 8; i++) {
        sum += output[0][i];
      }
      return sum / 8;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 8; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 8);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 8; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 8; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 8, 0).reshape([1, 8]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }
}

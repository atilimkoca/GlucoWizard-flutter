import 'dart:ffi';
import 'dart:math';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:collection/collection.dart';

class PredictionModel {
  late Interpreter _interpreter;
  Future load30Model(String text1, String text2, String text3, String text4,
      String text5, String text6) async {
    final interpreter = await Interpreter.fromAsset('thirty_min.tflite');
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

  Future load15Model(
    String text1,
    String text2,
    String text3,
  ) async {
    final interpreter = await Interpreter.fromAsset('fifteen_min.tflite');
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

  Future load45Model(
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
    String text7,
    String text8,
    String text9,
  ) async {
    final interpreter = await Interpreter.fromAsset('forty_five_min.tflite');
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
        double.parse(text9)
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 9; i++) {
        sum += output[0][i];
      }
      return sum / 9;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 9; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 9);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 9; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 9; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 9, 0).reshape([1, 9]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }

  Future load60Model(
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
    String text7,
    String text8,
    String text9,
    String text10,
    String text11,
    String text12,
  ) async {
    final interpreter = await Interpreter.fromAsset('sixty_min.tflite');
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
        double.parse(text9),
        double.parse(text10),
        double.parse(text11),
        double.parse(text12)
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 12; i++) {
        sum += output[0][i];
      }
      return sum / 12;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 12; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 12);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 12; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 12; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 12, 0).reshape([1, 12]);
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
    String text7,
    String text8,
    String text9,
    String text10,
    String text11,
    String text12,
    String text13,
    String text14,
    String text15,
    String text16,
    String text17,
    String text18,
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
        double.parse(text7),
        double.parse(text8),
        double.parse(text9),
        double.parse(text10),
        double.parse(text11),
        double.parse(text12),
        double.parse(text13),
        double.parse(text14),
        double.parse(text15),
        double.parse(text16),
        double.parse(text17),
        double.parse(text18),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 18; i++) {
        sum += output[0][i];
      }
      return sum / 18;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 18; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 18);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 18; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 18; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 18, 0).reshape([1, 18]);
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
    String text9,
    String text10,
    String text11,
    String text12,
    String text13,
    String text14,
    String text15,
    String text16,
    String text17,
    String text18,
    String text19,
    String text20,
    String text21,
    String text22,
    String text23,
    String text24,
  ) async {
    final interpreter = await Interpreter.fromAsset('onehundred.tflite');
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
        double.parse(text9),
        double.parse(text10),
        double.parse(text11),
        double.parse(text12),
        double.parse(text13),
        double.parse(text14),
        double.parse(text15),
        double.parse(text16),
        double.parse(text17),
        double.parse(text18),
        double.parse(text19),
        double.parse(text20),
        double.parse(text21),
        double.parse(text22),
        double.parse(text23),
        double.parse(text24),
      ]
    ];

    // if output tensor shape [1,2] and type is float32
    double calculateAverage(List<List<double>> output) {
      var sum = 0.0;

      for (var i = 0; i < 24; i++) {
        sum += output[0][i];
      }
      return sum / 24;
    }

    double calculateStandatdDeviation(List<List<double>> output) {
      var sum = 0.0;
      var average = calculateAverage(output);
      for (var i = 0; i < 24; i++) {
        sum += pow(output[0][i] - average, 2);
      }
      return sqrt(sum / 24);
    }

    List<List<double>> standardalize(
        List<List<double>> output, double mean, double standardDeviation) {
      var result = <List<double>>[];
      for (var i = 0; i < 24; i++) {
        result.add([(output[0][i] - mean) / standardDeviation]);
      }

      return result;
    }

    List<double> inverseTransform(
        List<dynamic> output, double mean, double standardDeviation) {
      var result = <double>[];
      for (var i = 0; i < 24; i++) {
        result.add(output[0][i] * standardDeviation + mean);
      }

      return result;
    }

    var mean = calculateAverage(input);
    var standardDeviation = calculateStandatdDeviation(input);

    input = standardalize(input, mean, standardDeviation);
    var output = List.filled(1 * 24, 0).reshape([1, 24]);
    interpreter.run(input, output);

    output = inverseTransform(output, mean, standardDeviation);

    return output[output.length - 1];
  }
}

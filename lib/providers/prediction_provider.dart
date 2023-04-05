import 'package:flutter/material.dart';

class PredictionProvider extends ChangeNotifier {
  TextEditingController? _predictionController;
  TextEditingController? get predictionController => _predictionController;
  setTextEditing(String text) {
    _predictionController!.text = text;
    notifyListeners();
  }
}

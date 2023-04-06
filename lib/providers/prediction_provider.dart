import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PredictionProvider extends ChangeNotifier {
  String? _selectedText;
  String? get selectedText => _selectedText;
  String? _head;
  String? get head => _head;
  String? _selectedValue;
  String? get selectedValue => _selectedValue;

  void setSelectedValue(String text) {
    _selectedValue = text;
    notifyListeners();
  }

  void setHead(String text) {
    _head = text;
    notifyListeners();
  }

  void setSelectedText(String text) {
    _selectedText = text;
    notifyListeners();
  }
}

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

  String? _selectedText2;
  String? get selectedText2 => _selectedText2;
  void setSelectedText2(String text) {
    _selectedText2 = text;
    notifyListeners();
  }

  String? _selectedValue2;
  String? get selectedValue2 => _selectedValue2;
  void setSelectedValue2(String text) {
    _selectedValue2 = text;
    notifyListeners();
  }

  String? _head2;
  String? get head2 => _head2;
  void setHead2(String text) {
    _head2 = text;
    notifyListeners();
  }
}

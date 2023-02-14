import 'package:flutter/material.dart';

class LineCellModel extends ChangeNotifier {
  LineCellModel({this.symbol = " "});

  String symbol;
  bool isActive = false;
  bool isFocus = false;

  void setSymbol(String symbol) {
    if (this.symbol != symbol) {
      this.symbol = symbol;
      notifyListeners();
    }
  }

  void setActive(bool isActive) {
    this.isActive = isActive;
    notifyListeners();
  }

  void setFocus(bool isFocus) {
    this.isFocus = isFocus;
    notifyListeners();
  }
}

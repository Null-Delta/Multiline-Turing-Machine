import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  int themeMode = 0;

  ThemeMode getMode() {
    return themeMode == 0
        ? ThemeMode.system
        : themeMode == 1
            ? ThemeMode.light
            : ThemeMode.dark;
  }

  void setMode(int mode) {
    themeMode = mode;
    notifyListeners();
  }
}

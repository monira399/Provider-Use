import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggleThemeMode() {
    if(themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    }else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }


}
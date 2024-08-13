import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode? _appThemeMode;

  getAppThemeMode() {
    return _appThemeMode ?? ThemeMode.light;
  }



  changeAppTheme() {
    if (getAppThemeMode() == ThemeMode.dark) {
      _appThemeMode = ThemeMode.light;
    } else {
      _appThemeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}

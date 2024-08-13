import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale? _appLocale;

  Locale getAppLocale() {
    return _appLocale ?? Locale('ar');
  }

  changeAppLocale() {
    if (getAppLocale().languageCode == "ar") {
      _appLocale = Locale("en");
    } else {
      _appLocale = Locale("ar");
    }
    notifyListeners();
    print("locale changed to ${getAppLocale().languageCode}");
  }
}

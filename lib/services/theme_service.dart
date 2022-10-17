import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeService(this.sharedPreferences);

  bool _darkTheme = true;
  static const String darkThemeKey = "dark_theme";

  bool get darkTheme => sharedPreferences.getBool(darkThemeKey) ?? _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreferences.setBool(darkThemeKey, value);
    notifyListeners();
  }
}

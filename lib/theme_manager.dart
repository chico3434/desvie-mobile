import 'package:flutter/material.dart';
import 'package:desvie/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData;

  final _themePreference = "theme_preference";

  ThemeManager() {
    _loadTheme();
  }

  void _loadTheme() {
    SharedPreferences.getInstance().then((prefs) {
      int preferredTheme = prefs.getInt(_themePreference) ?? 0;
      _themeData = appThemeData[AppTheme.values[preferredTheme]];
      notifyListeners();
    });
  }

  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.White];
    }
    return _themeData;
  }

  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme];
    notifyListeners();

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themePreference, AppTheme.values.indexOf(theme));
  }
}

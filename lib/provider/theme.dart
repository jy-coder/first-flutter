import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String _selectedTheme = "light";
  // use this as threshold
  double _readingFontSize = 16;

  void setSelectedTheme(String theme) async {
    _selectedTheme = theme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
    notifyListeners();
  }

  void setFontSize(double fontSize) async {
    _readingFontSize = fontSize;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', fontSize);
    notifyListeners();
  }

  String get theme {
    return _selectedTheme;
  }

  double get fontSize {
    return _readingFontSize;
  }

  Future<void> getStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeValue = prefs.getString('theme');
    double fontSizeValue = prefs.getDouble('fontSize');

    if (themeValue != null) _selectedTheme = themeValue;
    if (fontSizeValue != null) _readingFontSize = fontSizeValue;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  String _selectedTheme = "light";
  // use this as threshold
  double _readingFontSize = 16;

  void setSelectedTheme(theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  void setFontSize(fontSize) {
    _readingFontSize = fontSize;
    notifyListeners();
  }

  String get theme {
    return _selectedTheme;
  }

  double get fontSize {
    return _readingFontSize;
  }
}

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  String _selectedTheme = "light";

  void setSelectedTheme(theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  String get theme {
    return _selectedTheme;
  }
}

import 'package:finance_app/models/types/theme_type.dart';
import 'package:flutter/cupertino.dart';

class ThemeTypeNotifier with ChangeNotifier {
  ThemeType _themeType = ThemeType.LIGHT;

  ThemeType get themeType => _themeType;

  set themeType(ThemeType value) {
    _themeType = value;
    notifyListeners();
  }
}

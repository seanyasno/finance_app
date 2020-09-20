import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:flutter/foundation.dart';

class ThemeTypeNotifier with ChangeNotifier {
  ThemeType _themeType = ThemeType.LIGHT;

  ThemeType get themeType {
    SharedPreferences.getInstance().then((prefs) {
      _themeType = (prefs.getBool('dark_mode') ?? false) ? ThemeType.DARK : ThemeType.LIGHT;
      notifyListeners();
    });
    return _themeType;
  }

  set themeType(ThemeType value) {
    _themeType = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('dark_mode', value == ThemeType.DARK);
    });
    notifyListeners();
  }
}

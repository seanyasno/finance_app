import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:flutter/foundation.dart';

class ThemeTypeProvider with ChangeNotifier {
  ThemeType _themeType = ThemeType.LIGHT;
  bool _loaded = false;

  ThemeType get themeType {
    if (!_loaded) {
      SharedPreferences.getInstance().then((prefs) {
        _themeType =
        (prefs.getBool('dark_mode') ?? false) ? ThemeType.DARK : ThemeType
            .LIGHT;
        _updateStatusBar();
        _loaded = true;
      });
    }
    return _themeType;
  }

  set themeType(ThemeType value) {
    _themeType = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('dark_mode', value == ThemeType.DARK);
    });
    _updateStatusBar();
  }

  void _updateStatusBar() {
    print(_themeType);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: _themeType == ThemeType.DARK ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: _themeType == ThemeType.DARK ? Brightness.light : Brightness.dark,
    ));
    notifyListeners();
  }
}

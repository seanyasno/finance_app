import 'package:finance_app/models/app_theme_factory.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:finance_app/pages/profit/profit_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Finance',
      theme: AppThemeFactory.getThemeData(context, ThemeType.DARK),
      home: ProfitPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:finance_app/notifiers/ThemeTypeNotifier.dart';
import 'package:finance_app/pages/profit/profit_page.dart';
import 'package:finance_app/models/app_theme_factory.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ThemeTypeNotifier(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeType themeType = Provider.of<ThemeTypeNotifier>(context).themeType;

    return MaterialApp(
      title: 'Finance',
      theme: AppThemeFactory.getThemeData(context, themeType),
      home: ProfitPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

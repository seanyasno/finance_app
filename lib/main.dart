import 'package:finance_app/pages/profit/profit_page.dart';
import 'package:finance_app/models/app_theme_factory.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:finance_app/providers/calculators/calculator_desired_provider.dart';
import 'package:finance_app/providers/calculators/calculator_simple_provider.dart';
import 'package:finance_app/providers/theme_type_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ThemeTypeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CalculatorSimpleProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CalculatorDesiredProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeType themeType = Provider.of<ThemeTypeNotifier>(context).themeType;

    return StreamBuilder<bool>(
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
        title: 'Finance',
        theme: AppThemeFactory.getThemeData(context, ThemeType.LIGHT),
        home: ProfitPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

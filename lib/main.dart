import 'package:finance_app/notifiers/calculators/calculator_simple_notifier.dart';
import 'package:finance_app/notifiers/future_profit_form_notifier.dart';
import 'package:finance_app/notifiers/theme-type-notifier.dart';
import 'package:finance_app/notifiers/simple_profit_form_notifier.dart';
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
        ),
        ChangeNotifierProvider.value(
          value: SimpleProfitFormNotifier(),
        ),
        ChangeNotifierProvider.value(
          value: CalculatorSimpleNotifier(),
        ),
        ChangeNotifierProvider.value(
          value: FutureProfitFormNotifier(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeType themeType = Provider.of<ThemeTypeNotifier>(context).themeType;

    return StreamBuilder<bool>(
      initialData: themeType == ThemeType.DARK,
      builder: (context, snapshot) => MaterialApp(
        title: 'Finance',
        theme: AppThemeFactory.getThemeData(context, themeType),
        home: ProfitPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

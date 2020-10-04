import 'package:finance_app/components/forms/calculator_desired_form.dart';
import 'package:finance_app/components/forms/calculator_simple_form.dart';
import 'package:finance_app/notifiers/theme-type-notifier.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfitPage extends StatefulWidget {
  @override
  _ProfitPageState createState() => _ProfitPageState();
}

class _ProfitPageState extends State<ProfitPage> {
  @override
  Widget build(BuildContext context) {
    ThemeTypeNotifier themeTypeNotifier =
        Provider.of<ThemeTypeNotifier>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            'Profit Calculator',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline6.color,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          bottom: TabBar(
            indicatorColor: Theme.of(context).indicatorColor,
            labelColor: Theme.of(context).textTheme.subtitle1.color,
            tabs: [
              Tab(
                text: 'Simple',
              ),
              Tab(
                text: 'Desired',
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: CalculatorSimpleForm(),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: CalculatorDesiredForm(),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              children: [
                SwitchListTile(
                  activeColor: Colors.greenAccent,
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2.color),
                  ),
                  value: themeTypeNotifier.themeType == ThemeType.DARK,
                  onChanged: (value) {
                    if (value)
                      themeTypeNotifier.themeType = ThemeType.DARK;
                    else
                      themeTypeNotifier.themeType = ThemeType.LIGHT;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

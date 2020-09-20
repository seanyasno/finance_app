import 'package:finance_app/components/profit_forms/future_profit_form/future_profit_form.dart';
import 'package:finance_app/components/profit_forms/simple_profit_form/simple_profit_form.dart';
import 'package:flutter/material.dart';

class ProfitPage extends StatefulWidget {
  @override
  _ProfitPageState createState() => _ProfitPageState();
}

class _ProfitPageState extends State<ProfitPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
                child: SimpleProfitForm(),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: FutureProfitForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          elevation: 0,
          title: Text(
            'Profit Calculator',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
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
        backgroundColor: Colors.white,
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

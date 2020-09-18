import 'package:finance_app/pages/profit/profit_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      theme: ThemeData(
        primaryColor: Color(0xFF2F80ED),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerColor: Colors.transparent,
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      home: ProfitPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:finance_app/models/types/theme_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppThemeFactory {
  static ThemeData getThemeData(BuildContext context, ThemeType themeType) {
    final lightTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
        );
    final darkTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        );

    switch (themeType) {
      case ThemeType.LIGHT:
        return ThemeData(
          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          dividerColor: Colors.transparent,
          textTheme: GoogleFonts.ralewayTextTheme(lightTextTheme),
          backgroundColor: Colors.white,
          indicatorColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          cursorColor: Colors.white,
        );
      case ThemeType.DARK:
        return ThemeData(
          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          dividerColor: Colors.transparent,
          textTheme: GoogleFonts.ralewayTextTheme(darkTextTheme),
          backgroundColor: Color(0xFF2D2D2D),
          indicatorColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          cursorColor: Colors.white,
        );
      default:
        return null;
    }
  }
}

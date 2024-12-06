import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_refactor/core/extension/context_ext.dart';
import 'package:weather_app_refactor/core/res/colours.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light(BuildContext context) => ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colours.lightScaffold,
        textTheme: GoogleFonts.poppinsTextTheme(context.textTheme).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        canvasColor: Colours.canvasColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
      );

  static ThemeData dark(BuildContext context) => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(context.textTheme).apply(
          bodyColor: Colours.primaryColour,
          displayColor: Colours.accentColour,
        ),
        canvasColor: Colours.canvasColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
      );
}

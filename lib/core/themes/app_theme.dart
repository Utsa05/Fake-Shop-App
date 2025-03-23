import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_pallete.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppPallete.indigoColor,
    scaffoldBackgroundColor: AppPallete.whiteColor,
    textTheme: textThemeLight,
    appBarTheme: appBarLightTheme,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppPallete.blueGreyColor,
    scaffoldBackgroundColor: AppPallete.blackColor,
    textTheme: textThemeDark,
    appBarTheme: appBarDarkTheme,
  );

  static final TextTheme textThemeLight = TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppPallete.blackColor),
    displayMedium: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppPallete.blackColor),
    displaySmall: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppPallete.blackColor),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppPallete.blackColor),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppPallete.blackColor),
    bodySmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppPallete.blackColor),
  );

  static final TextTheme textThemeDark = TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppPallete.whiteColor),
    displayMedium: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppPallete.whiteColor),
    displaySmall: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppPallete.whiteColor),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppPallete.whiteColor),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppPallete.whiteColor),
    bodySmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppPallete.whiteColor),
  );

  static final AppBarTheme appBarLightTheme = AppBarTheme(
      backgroundColor: AppPallete.indigoColor,
      titleTextStyle: GoogleFonts.poppins(
          color: AppPallete.whiteColor,
          fontSize: 17,
          fontWeight: FontWeight.w600));
  static final AppBarTheme appBarDarkTheme = AppBarTheme(
      backgroundColor: AppPallete.blueGreyColor,
      titleTextStyle: GoogleFonts.poppins(
          color: AppPallete.whiteColor,
          fontSize: 17,
          fontWeight: FontWeight.w600));
}

// light theme
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxialong/core/utils/colors.dart';

ThemeData lighttheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
);
// dark theme

ThemeData darktheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.robotoFlex(
      fontSize: 36.sp,
      color: white,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: GoogleFonts.robotoFlex(),
    displaySmall: GoogleFonts.robotoFlex(),
    headlineLarge: GoogleFonts.robotoFlex(),
    headlineMedium: GoogleFonts.robotoFlex(),
    headlineSmall: GoogleFonts.robotoFlex(),
    titleLarge: GoogleFonts.robotoFlex(),
    titleMedium: GoogleFonts.robotoFlex(),
    titleSmall: GoogleFonts.robotoFlex(),
    bodyLarge: GoogleFonts.robotoFlex(),
    bodyMedium: GoogleFonts.robotoFlex(),
    bodySmall: GoogleFonts.robotoFlex(),
    labelLarge: GoogleFonts.robotoFlex(),
    labelMedium: GoogleFonts.robotoFlex(),
    labelSmall: GoogleFonts.robotoFlex(),

    // button
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: primaryColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor,
  ),
);

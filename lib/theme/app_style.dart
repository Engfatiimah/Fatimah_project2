import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const paper = Color(0xFFFFFDF9);
  static const cherry = Color(0xFFC8362B);
  static const cherryDark = Color(0xFF9E2A21);
  static const cream = Color(0xFFF6EFE3);
  static const sand = Color(0xFFDCCDB4);
  static const ink = Color(0xFF2B1E1A);
  static const muted = Color(0xFF9C8E7A);
}

class AppFonts {
  AppFonts._();

  static TextStyle pacifico({
    double fontSize = 24,
    Color color = AppColors.ink,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.pacifico(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );

  static TextStyle baloo({
    double fontSize = 14,
    Color color = AppColors.ink,
    FontWeight fontWeight = FontWeight.w400,
    double? letterSpacing,
    double? height,
  }) =>
      GoogleFonts.baloo2(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      );
}

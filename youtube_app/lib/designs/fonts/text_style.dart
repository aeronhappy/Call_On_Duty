import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleText(double fontSize, FontWeight fontWeight, Color color) =>
    GoogleFonts.montserrat(
        decoration: TextDecoration.none,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight);

TextStyle bodyText(double fontSize, FontWeight fontWeight, Color color) =>
    GoogleFonts.montserrat(
        decoration: TextDecoration.none,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color);

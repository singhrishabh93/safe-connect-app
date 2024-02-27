import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

double? deviceHeight;
double? deviceWidth;

Color backgroundColor = const Color(0xffffffff);
Color highlightColor = const Color(0xfff5f5f5);
Color secondaryColor = const Color(0xff3d3c3c);
Color primaryColor = const Color(0xffff822c);

TextStyle textStyle(double fontSize, Color fontColor,
    {FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
    color: fontColor,
    fontSize: fontSize,
    fontFamily: "themefont",
    fontWeight: fontWeight,
    decoration: TextDecoration.none,
  );
}

class CustomThemes {
  static final lightTheme = ThemeData(
    cardColor: Colors.white,
    fontFamily: "poppins",
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Vx.gray800,
    iconTheme: const IconThemeData(
      color: Vx.gray600,
      // color: Vx.gray600,
    ),
  );
  static final darkTheme = ThemeData(
    cardColor: backgroundColor.withOpacity(0.6),
    fontFamily: "poppins",
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}

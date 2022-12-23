import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme_work/theme_colors.dart';

class ThemeTexts {
  ThemeTexts._();

  static const textStyleTitle1 = TextStyle(
      fontSize: 25,
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1,
      decoration: TextDecoration.none,
  );

  static const textStyleTitle2 = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    decoration: TextDecoration.none
  );

  static const textStyleTitle2Black = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    decoration: TextDecoration.none
  );

  static const textStyleTitle3 = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    decoration: TextDecoration.none
  );

  static const textStyleValueBlack =  TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    decoration: TextDecoration.none
  );

  static const textStyleValueBlack2 =  TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    letterSpacing: 1.5,
    decoration: TextDecoration.none
  );

  static const textStyleValueGrey =  TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    decoration: TextDecoration.none
  );

  static var appbar_text_style =
      textStyleTitle1.copyWith(color: Colors.black87, letterSpacing: 2);
  static var action_text_style = textStyleTitle1.copyWith(
      fontSize: 22, color: Colors.black87, letterSpacing: 0.5);

  static var button_text_style =
      textStyleTitle2.copyWith(fontSize: 18, color: Colors.white);

  static var snakbar_text = textStyleTitle2.copyWith(
    color: Colors.white,
  );

  static const textCupertinoTitleStyle = textStyleTitle1;

  static var overline = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey[500]);

  static final textThemeLT = TextTheme(
    overline: overline.copyWith(color: ThemeColors.overline_color_lt),
  );
}

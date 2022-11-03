import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme_work/theme_colors.dart';

class ThemeTexts {
  ThemeTexts._();

  static const String GilroyExtraBold = "Gilroy-ExtraBold";
  static const String GilroyLight = "Gilroy-Light";
  static const String GilroyMedium = "Gilroy-Medium";
  static const String GilroyRegular = "Gilroy-Regular";
  static const String GilroySemibold = "Gilroy-Semibold";

  static const textStyleTitle1 = TextStyle(
      fontSize: 25,
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1,
      decoration: TextDecoration.none,
      fontFamily: GilroySemibold);

  static const textStyleTitle2 = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    decoration: TextDecoration.none,
    fontFamily: GilroyMedium,
  );

  static const textStyleTitle3 = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    decoration: TextDecoration.none,
    fontFamily: GilroyMedium,
  );

  static const textStyleValueBlack =  TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    decoration: TextDecoration.none,
    fontFamily: GilroySemibold,
  );

  static const textStyleValueBlack2 =  TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    letterSpacing: 1.5,
    decoration: TextDecoration.none,
    fontFamily: GilroySemibold,
  );

  static const textStyleValueGrey =  TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    decoration: TextDecoration.none,
    fontFamily: GilroySemibold,
  );

  static var appbar_text_style =
      textStyleTitle1.copyWith(color: Colors.black87, letterSpacing: 2);
  static var action_text_style = textStyleTitle1.copyWith(
      fontSize: 22, color: Colors.black87, letterSpacing: 0.5);

  static var button_text_style =
      textStyleTitle2.copyWith(fontSize: 18, color: Colors.white);

  static var snakbar_text = textStyleTitle2.copyWith(
    color: Colors.white,
    fontFamily: GilroyRegular,
  );

  static const textCupertinoTitleStyle = textStyleTitle1;

  // // Description
  // static var heading_01 = TextStyle(
  //     fontSize: 25,
  //     fontFamily: Bold,
  //     fontWeight: FontWeight.w600,
  //     letterSpacing: 1.5);
  //
  // static var heading_02 = TextStyle(
  //     fontSize: 22,
  //     // wordSpacing: 12,
  //     fontFamily: Bold,
  //     fontWeight: FontWeight.w400,
  //     letterSpacing: 2);
  //
  // static var heading_03 = TextStyle(
  //     fontSize: 19,
  //     // wordSpacing: 12,
  //     fontFamily: Bold,
  //     fontWeight: FontWeight.w600,
  //     height: 1);
  //
  // //Dialog Normal Text
  // static var heading_04 = TextStyle(
  //     fontSize: 18,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w500,
  //     letterSpacing: 1);
  //
  // // Description
  // static var heading_05 = TextStyle(
  //     fontSize: 16,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w500,
  //     letterSpacing: 1);
  //
  // ///TextFormField
  // static var heading_06 = TextStyle(
  //     fontSize: 18,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w400,
  //     letterSpacing: 1);
  //
  // static var subtitle_01 = TextStyle(
  //     fontSize: 16,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w700,
  //     color: Colors.white,
  //     letterSpacing: 2);
  //
  // static var subtitle_02 = TextStyle(
  //     fontSize: 16,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w700,
  //     color: ThemeColors.primary_dark_lt,
  //     letterSpacing: 2);
  //
  // static var caption = TextStyle(
  //     fontSize: 16,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w700,
  //     color: ThemeColors.primary_dark_lt,
  //     letterSpacing: 2);
  //
  // static var bodyText_01 = TextStyle(
  //     fontSize: 19,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w400,
  //     letterSpacing: 1);
  //
  // static var bodyText_02 = TextStyle(
  //     fontSize: 18,
  //     // wordSpacing: 12,
  //     fontFamily: Regular,
  //     fontWeight: FontWeight.w400,
  //     letterSpacing: 1);

  static var overline = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey[500]);

  static final textThemeLT = TextTheme(
    // headline1: heading_01.copyWith(color: ThemeColors.headline1_color_lt),
    // headline2: heading_02.copyWith(color: ThemeColors.headline2_color_lt),
    // headline3: heading_03.copyWith(color: ThemeColors.headline3_color_lt),
    // headline4: heading_04.copyWith(color: ThemeColors.headline4_color_lt),
    // headline5: heading_05.copyWith(color: ThemeColors.headline5_color_lt),
    // headline6: heading_06.copyWith(color: ThemeColors.headline6_color_lt),
    // subtitle1: subtitle_01.copyWith(color: ThemeColors.subtitle1_color_lt),
    // subtitle2: subtitle_02.copyWith(color: ThemeColors.subtitle2_color_lt),
    // bodyText1: bodyText_01.copyWith(color: ThemeColors.bodyText1_color_lt),
    // bodyText2: bodyText_02.copyWith(color: ThemeColors.bodyText2_color_lt),
    // caption: caption.copyWith(color: ThemeColors.caption_color_lt),
    overline: overline.copyWith(color: ThemeColors.overline_color_lt),
  );
}

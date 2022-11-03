import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme_colors.dart';
import '../app_theme/theme_texts.dart';

class LightThemeData {
  LightThemeData._();

  static final border_radius = BorderRadius.all(Radius.circular(0));
  static double border_width = 0;

  static Map<int, Color> colorMap = {
    50: Color.fromRGBO(255, 255, 255, .1),
    100: Color.fromRGBO(255, 255, 255, .2),
    200: Color.fromRGBO(255, 255, 255, .3),
    300: Color.fromRGBO(255, 255, 255, .4),
    400: Color.fromRGBO(255, 255, 255, .5),
    500: Color.fromRGBO(255, 255, 255, .6),
    600: Color.fromRGBO(255, 255, 255, .7),
    700: Color.fromRGBO(255, 255, 255, .8),
    800: Color.fromRGBO(255, 255, 255, .9),
    900: Color.fromRGBO(255, 255, 255, 1),
  };

  static final light_theme = ThemeData(
    primarySwatch: MaterialColor(0xFFffffff, colorMap),
    canvasColor: Colors.green,
    backgroundColor: ThemeColors.background,
    primaryColorDark: ThemeColors.primary_dark_lt,
    scaffoldBackgroundColor: ThemeColors.scaffold_color_lt,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ThemeColors.primaryColor,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: new Offset(6.0, 6.0),
            ), //BoxShadow
          ],
          color: Colors.greenAccent[400]),
    ),
    colorScheme: ColorScheme(
      primary: ThemeColors.primaryColor,
      primaryVariant: ThemeColors.primary_varient_lt,
      secondary: ThemeColors.primary_dark_lt,
      secondaryVariant: ThemeColors.primary_dark_lt,
      surface: Colors.grey,
      background: ThemeColors.background,
      error: Colors.white,
      onPrimary: ThemeColors.primaryColor,
      onSecondary: Colors.cyan,
      // onSecondary: ThemeColors.primary_dark_lt,
      onSurface: Colors.white,
      onBackground: Colors.black87,
      onError: ThemeColors.primary_yellow_lt,
      brightness: Brightness.light,
    ),
    textTheme: ThemeTexts.textThemeLT,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(ThemeColors.primaryColor),
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.all(
        ThemeTexts.button_text_style,
      ),
    )),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ThemeColors.textformback_color_lt, // background
      // border: InputBorder.none,
      // enabledBorder: InputBorder.none,
      // focusedBorder: InputBorder.none,
      // errorBorder: InputBorder.none,
      filled: true,

      border: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: BorderSide(
          color: Colors.white,
          width: border_width,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: BorderSide(
          color: Colors.white,
          width: border_width,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: BorderSide(
          color: Colors.white,
          width: border_width,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: BorderSide(
          color: Colors.white,
          width: border_width,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: ThemeColors.primaryColor,
          textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[200],
      elevation: 0,
      // shape: BoxShape.rectangle
    ),
    appBarTheme: AppbarTheme,
    iconTheme: IconThemeData(color: Colors.black87, size: 22),
  );

  //AppBar Theme
  static final AppbarTheme = AppBarTheme(
    backgroundColor: ThemeColors.background,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    titleTextStyle: ThemeTexts.appbar_text_style,
    actionsIconTheme: IconThemeData(
      color: ThemeColors.primaryColor,
      size: 24,
    ),
  );
}

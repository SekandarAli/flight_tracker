// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme_work/light_theme_data.dart';
import 'package:flutter/material.dart';
import 'screens/bottom_navbar/bottom_navbar_screen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: ColorsTheme.primaryColor
      ),
      home: BottomNavBarScreen(),
    );
  }
}

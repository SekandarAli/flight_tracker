// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/bottom_navbar/bottom_navbar_screen.dart';
import 'package:flight_tracker/myflights/model/myflights_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<ModelMyFlights>(ModelMyFlightsAdapter());
  await Hive.openBox<ModelMyFlights>("modelMyFlights");

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: ColorsTheme.primaryColor),
      home: BottomNavBarScreen(),
      // home: AirportTrackFlight(),
    );
  }
}
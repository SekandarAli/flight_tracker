// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/bottom_navbar/bottom_navbar_screen.dart';
import 'package:flight_tracker/flight_detail/screen/flight_detail_airport_airline.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

import 'dummy/polygon_location_sevice.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Hive.initFlutter();

  Hive.registerAdapter<ModelMyFlightsUpcoming>(ModelMyFlightsUpcomingAdapter());
  Hive.registerAdapter<ModelMyFlightsCreateTrip>(ModelMyFlightsCreateTripAdapter());
  Hive.registerAdapter<ModelSearch>(ModelSearchAdapter());
  // Hive.registerAdapter<ModelNew>(ModelNewAdapter());
  await Hive.openBox<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  await Hive.openBox<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
  await Hive.openBox<ModelSearch>("modelSearch");
  // await Hive.openBox<ModelNew>("modelNew");

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
      title: "FLIGHT TRACK",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: ColorsTheme.primaryColor,
        fontFamily: "OpenSansRegular"
        // textTheme: GoogleFonts.montserratTextTheme(
        //   Theme.of(context).textTheme,),
      ),
      home: BottomNavBarScreen(),
      // home: FlightDetailAirportAirline(flight_iata: "AA6"),
      // home: dummy(),
    );
  }
}

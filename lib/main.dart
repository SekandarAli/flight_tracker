// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/airports/screen/airport_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/bottom_navbar/bottom_navbar_screen.dart';
import 'package:flight_tracker/flight_detail/screen/flight_detail_airport_airline.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/notifications/notification_page.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get_storage/get_storage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Hive.initFlutter();

  Hive.registerAdapter<ModelMyFlightsUpcoming>(ModelMyFlightsUpcomingAdapter());
  await Hive.openBox<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  Hive.registerAdapter<ModelMyFlightsCreateTrip>(ModelMyFlightsCreateTripAdapter());
  await Hive.openBox<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
  Hive.registerAdapter<ModelSearch>(ModelSearchAdapter());
  await Hive.openBox<ModelSearch>("modelSearch");
  // Hive.registerAdapter<ModelNew>(ModelNewAdapter());
  // await Hive.openBox<ModelNew>("modelNew");

  await GetStorage.init();
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
      // home: FlightDetailAirportAirline(flight_iata: "IX142",),
      home: BottomNavBarScreen(),
      // home: NotificationPage(),
    );
  }
}

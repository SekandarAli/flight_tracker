// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/recent_airport_airline_search/model/model_recent_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/settings/screen/setting_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../app_theme/reusing_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Box<ModelMyFlightsUpcoming>? dataTrackFlights;
  Box<ModelSearch>? dataRecentSearch;
  Box<ModelRecentSearch>? dataRecentAirportAndAirline;
  Box<ModelMyFlightsCreateTrip>? dataCreateTrips;

  bool forDeparture = true;
  bool forArrival = true;

  @override
  void initState() {
    super.initState();
    dataTrackFlights = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    dataRecentSearch = Hive.box<ModelSearch>("modelSearch");
    dataRecentAirportAndAirline = Hive.box<ModelRecentSearch>("modelRecentSearch");
    dataCreateTrips = Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsTheme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Settings",
                      style: ThemeTexts.textStyleTitle2.copyWith(letterSpacing: 2),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: Container(
                decoration: ReusingWidgets().curveDecorationContainer(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 20),
                    ListTile(
                      leading: iconStyle(icon: Icons.add_alert),
                      title: textStyle(text: "Alert Settings"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Text(""),
                      title: textStyle(text: "Departure Reminder"),
                      onTap: () {},
                        trailing: Switch(
                            activeColor: ColorsTheme.primaryColor,
                            inactiveThumbColor: Colors.grey.shade200,
                            inactiveTrackColor: Colors.grey,
                            splashRadius: 50.0,
                            value: forDeparture,
                            onChanged: (value) => setState(() => forDeparture = value)
                        )
                    ),
                    ListTile(
                      leading: Text(""),
                      title: textStyle(text: "Arrival Reminder"),
                      onTap: () {},
                      trailing: Switch(
                        activeColor: ColorsTheme.primaryColor,
                        inactiveThumbColor: Colors.grey.shade200,
                        inactiveTrackColor: Colors.grey,
                        splashRadius: 50.0,
                        value: forArrival,
                        onChanged: (value) => setState(() => forArrival = value),
                      ),
                    ),
                    ListTile(
                      leading: iconStyle(icon: Icons.search_off_rounded),
                      title: textStyle(text: "Clear Searches"),
                      onTap: () {
                        deleteDialogue(boxData: dataRecentSearch!);
                      },
                    ),
                    ListTile(
                      leading: iconStyle(icon: Icons.remove_circle_outline),
                      title: textStyle(text: "Clear Trips"),
                      onTap: () {
                        deleteDialogue(boxData: dataCreateTrips!);
                      },
                    ),
                    ListTile(
                      leading: iconStyle(icon: Icons.delete_forever_outlined),
                      title: textStyle(text: "Clear Flights"),
                      onTap: () {
                        deleteDialogue(boxData: dataTrackFlights!);
                      },
                    ),
                    ListTile(
                      leading: iconStyle(icon: Icons.star),
                      title: textStyle(text: "Rate Us"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: iconStyle(icon: Icons.share),
                      title: textStyle(text: "Share"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: iconStyle(icon: Icons.privacy_tip_outlined),
                      title: textStyle(text: "Privacy Policy"),
                      onTap: () {},
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> deleteDialogue({required var boxData}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to Clear Data?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('CANCEL')),
            TextButton(
                onPressed: () {
                  ReusingWidgets().snackBar(context: context, text: "Data Deleted Successfully!");
                  boxData.clear();
                  Navigator.of(context).pop();
                },
                child: Text('OK')),
          ],
        );
      });

  Widget textStyle({
    required String text,
  }){
    return Text(
      text,
      style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
    );
  }
  Icon iconStyle({
    required IconData icon,
  }){
    return Icon(icon,color: ColorsTheme.themeColor,);
  }
}
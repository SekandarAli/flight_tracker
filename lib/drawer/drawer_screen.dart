// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app_theme/reusing_widgets.dart';
import '../myflights/model/my_flight_create_trip_model.dart';
import '../myflights/model/myflights_upcoming_model.dart';
import '../recent_airport_airline_search/model/model_recent_search.dart';
import '../search/screen/search_tab_recent_searches/model/model_search.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

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
    return SizedBox(
      width: w / 1.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorsTheme.primaryColor,
                // border: Border.all(
                //     color: ColorsTheme.white, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.flight,
                      size: 60,
                      color: ColorsTheme.white,),
                  ),
                  Text('Flight Tracker',style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.white,fontSize: 20),),
                ],
              ),
            ),

            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: iconStyle(icon: Icons.add_alert),
                title: textStyle(text: "Alert Settings"),
                children: [
                  ListTile(
                    title: Text(
                      "Departure Reminder",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
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
                    title: Text(
                      "Arrival Reminder",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    trailing: Switch(
                      activeColor: ColorsTheme.primaryColor,
                      inactiveThumbColor: Colors.grey.shade200,
                      inactiveTrackColor: Colors.grey,
                      splashRadius: 50.0,
                      value: forArrival,
                      onChanged: (value) => setState(() => forArrival = value),
                    ),
                  )
                ],
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
    );
  }
  Future<String?> deleteDialogue({required var boxData}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          title: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width ,
              color: ColorsTheme.primaryColor,
              child: Text("Clear Data",style: ThemeTexts.textStyleTitle2,)),
          content: Container(
            padding: EdgeInsets.all(20),
            child: Text(
                "Are you sure you want to Clear Data?")),
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

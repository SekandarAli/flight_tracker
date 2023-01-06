// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/recent_airport_airline_search/model/model_recent_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/settings/screen/setting_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

import '../../app_theme/reusing_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final box = GetStorage();
  Box<ModelMyFlightsUpcoming>? dataTrackFlights;
  Box<ModelSearch>? dataRecentSearch;
  Box<ModelRecentSearch>? dataRecentAirportAndAirline;
  Box<ModelMyFlightsCreateTrip>? dataCreateTrips;
  String editName = "👤";
  TextEditingController nameController = TextEditingController();

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
    box.writeIfNull('editName', editName);
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
            // Spacer(),
            Expanded(
              flex: 1,
              child: Container(
                // height: h * 0.8,
                // width: w,
                decoration: ReusingWidgets().curveDecorationContainer(),
                child: ListView(
                  padding: EdgeInsets.all(12),
                  children: [
                    SizedBox(height: 20.0),
                    ReusingWidgets().settingListTiles(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingAlert()));
                      },
                      title: "Alert",
                      subTitle: "Alert default notifications",
                      icon: Icons.add_alert,
                      iconColor: ColorsTheme.primaryColor,
                    ),
                    SizedBox(height: 20.0),
                    ReusingWidgets().settingListTiles(
                        onTap: (){
                          deleteDialogue(boxData: dataRecentSearch!);
                        },
                        title: "Clear Recent Searches",
                        subTitle: "This is irreversible and your data will be remove",
                        icon: Icons.search_off_rounded,
                        iconColor: ColorsTheme.dismissibleColor,
                    ),
                    SizedBox(height: 20.0),
                    ReusingWidgets().settingListTiles(
                        onTap: (){
                          deleteDialogue(boxData: dataCreateTrips!);
                        },
                        title: "Clear All Created Trips",
                        subTitle: "Remove your created trips of MyFlights",
                        icon: Icons.remove_circle_outline,
                        iconColor: ColorsTheme.dismissibleColor,
                    ),
                    SizedBox(height: 20.0),
                    ReusingWidgets().settingListTiles(
                        onTap: (){
                          deleteDialogue(boxData: dataTrackFlights!);
                        },
                        title: "Clear Track Flights",
                        subTitle: "This is irreversible and your data will be remove",
                        icon: Icons.delete_forever_outlined,
                        iconColor: ColorsTheme.dismissibleColor,
                    ),
                    // SizedBox(height: 20.0),
                    // ReusingWidgets().settingListTiles(
                    //     onTap: (){
                    //       ReusingWidgets().snackBar(context: context, text: "Not Working Yet!");
                    //     },
                    //     title: "Theme",
                    //     subTitle: "Change Your Theme to Dark or Light",
                    //     icon: Icons.dark_mode,
                    //     iconColor: ColorsTheme.black,
                    // )
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

}
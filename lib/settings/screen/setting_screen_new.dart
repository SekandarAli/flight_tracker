// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/recent_airport_airline_search/model/model_recent_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/settings/screen/setting_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

import '../../app_theme/reusing_widgets.dart';

class SettingsScreenNew extends StatefulWidget {
  const SettingsScreenNew({Key? key}) : super(key: key);

  @override
  _SettingsScreenNewState createState() => _SettingsScreenNewState();
}

class _SettingsScreenNewState extends State<SettingsScreenNew> {
  final box = GetStorage();
  Box<ModelMyFlightsUpcoming>? dataTrackFlights;
  Box<ModelSearch>? dataRecentSearch;
  Box<ModelRecentSearch>? dataRecentAirportAndAirline;
  String editName = "👤";
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataTrackFlights = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    dataRecentSearch = Hive.box<ModelSearch>("modelSearch");
    dataRecentAirportAndAirline = Hive.box<ModelRecentSearch>("modelRecentSearch");
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
            Container(
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
            Spacer(),
            Container(
              height: h * 0.8,
              width: w,
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
                        dataRecentSearch!.clear();
                        ReusingWidgets().snackBar(context: context, text: "Track Flights Deleted Successfully!");
                      },
                      title: "Clear Recent Searches",
                      subTitle: "This is irreversible and your data will be remove",
                      icon: Icons.search_off_rounded,
                      iconColor: ColorsTheme.dismissibleColor,
                  ),
                  SizedBox(height: 20.0),
                  ReusingWidgets().settingListTiles(
                      onTap: (){
                        dataRecentAirportAndAirline!.clear();
                        ReusingWidgets().snackBar(context: context, text: "Track Flights Deleted Successfully!");
                      },
                      title: "Clear Recent Airports & Airlines",
                      subTitle: "Remove your recent searches of Airports and Airlines",
                      icon: Icons.remove_circle_outline,
                      iconColor: ColorsTheme.dismissibleColor,
                  ),
                  SizedBox(height: 20.0),
                  ReusingWidgets().settingListTiles(
                      onTap: (){
                        dataTrackFlights!.clear();
                        ReusingWidgets().snackBar(context: context, text: "Track Flights Deleted Successfully!");
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
          ],
        ),
      ),
    );
  }

}
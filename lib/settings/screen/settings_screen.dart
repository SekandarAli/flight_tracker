// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    String editName = "Your Name Here";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: h * 0.3,
              width: w,
              color: ColorsTheme.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "$editName  ",
                        style: ThemeTexts.textStyleTitle2.copyWith(
                            fontWeight: FontWeight.normal, letterSpacing: 3),
                      ),
                      Icon(Icons.edit,color: Colors.white,)
                    ],
                  ),
                  Text(
                    "The Flight Tracker",
                    style: ThemeTexts.textStyleTitle3,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text("Flights"),
                  //     Text("Flights"),
                  //     Text("Flights"),
                  //   ],
                  // ),
                ],
              )),
          settingsTile(title: "Application Setting"),
          settingsTile(title: "Alert Default Settings"),
          settingsTile(title: "Triplt"),
          settingsTile(title: "Privacy Settings"),
          settingsTile(
              title: "Subscribe", subTitle: "Gain access to premium features"),
          settingsTile(title: "Frequently Asked Questions", subTitle: "FAQ"),
          settingsTile(
              title: "License Information",
              subTitle: "License for included libraries"),
        ],
      ),
    );
  }

  Widget settingsTile({
    required String title,
    String subTitle = "",
  }) {
    return GestureDetector(
      onTap: () {
        print("aaa");
      },
      child: Container(
        padding: EdgeInsets.only(left: 30, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: ThemeTexts.textStyleTitle3.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal)),
            SizedBox(height: 3),
            Text(subTitle,
                style: ThemeTexts.textStyleValueGrey
                    .copyWith(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

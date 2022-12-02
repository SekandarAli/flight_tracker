// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

import '../../app_theme/reusing_widgets.dart';

class SettingAlert extends StatefulWidget {
  const SettingAlert({Key? key}) : super(key: key);

  @override
  State<SettingAlert> createState() => _SettingAlertState();
}

class _SettingAlertState extends State<SettingAlert> {

  bool forDeparture = true;
  bool forArrival = true;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Alert Settings"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
              padding: EdgeInsets.only(left: 30,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Scheduled Departure"),
                  Switch(
                    activeColor: ColorsTheme.primaryColor,
                    activeTrackColor: Colors.lightBlueAccent,
                    inactiveThumbColor: Colors.grey.shade200,
                    inactiveTrackColor: Colors.grey,
                    splashRadius: 50.0,
                    value: forDeparture,
                    onChanged: (value) => setState(() => forDeparture = value),
                  ),
                ],
              ),
            ),
              Container(
              padding: EdgeInsets.only(left: 30,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Scheduled Arrival"),
                  Switch(
                    activeColor: ColorsTheme.primaryColor,
                    activeTrackColor: Colors.lightBlueAccent,
                    inactiveThumbColor: Colors.grey.shade200,
                    inactiveTrackColor: Colors.grey,
                    splashRadius: 50.0,
                    value: forArrival,
                    onChanged: (value) => setState(() => forArrival = value),
                  ),
                ],
              ),
            ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget settingsTile({required bool isValue,required String text}) {
    return Container(
      padding: EdgeInsets.only(left: 30,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Switch(
            activeColor: ColorsTheme.primaryColor,
            activeTrackColor: Colors.lightBlueAccent,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            splashRadius: 50.0,
            value: isValue,
            onChanged: (value) => setState(() => isValue = value),
          ),
        ],
      ),
    );
  }
}

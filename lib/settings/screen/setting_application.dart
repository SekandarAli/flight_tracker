// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

import '../../app_theme/reusing_widgets.dart';

class SettingApplication extends StatefulWidget {
  const SettingApplication({Key? key}) : super(key: key);

  @override
  State<SettingApplication> createState() => _SettingApplicationState();
}

class _SettingApplicationState extends State<SettingApplication> {

  String editName = "Your Name Here";
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Application Settings"),),
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
                  settingsTile(title: "Clear recent Searches",subTitle: "Clear your recent searches",
                      onTap: (){}),
                  settingsTile(title: "Show Layovers",subTitle: "Show Layovers for Tracked Flights"),
                  settingsTile(title: "Show My Trips",subTitle: "Show My Trips at top of My Flights"),
                  settingsTile(title: "Select Map type"),
                  settingsTile(title: "Temperature Unit"),
                  settingsTile(title: "Distance Unit"),
                  settingsTile(title: "Auto Delete Flights"),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget settingsTile({
    required String title,
    String subTitle = "",
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.only(left: 50, top: 20),
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
  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: TextFormField(
                  controller: nameController,
                  maxLength: 10,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "Enter Your Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(nameController.text.toString());
                },
                    child: Text('DONE')),
              ],
            ),
          ],
        );
      });
}
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
      backgroundColor: ColorsTheme.primaryColor,
      body:  SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                  Text("Alert Settings",
                    style: ThemeTexts.textStyleTitle2.copyWith(letterSpacing: 2),
                  ),
                  SizedBox()

                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: h * 0.85,
              width: w,
              decoration: ReusingWidgets().curveDecorationContainer(),
              child: ListView(
                padding: EdgeInsets.all(12),
                children: [
                  listTiles(
                    onTap: (){},
                    title: "Departure",
                    subTitle: "Scheduled departure Changes",
                    container: Switch(
                      activeColor: ColorsTheme.primaryColor,
                      inactiveThumbColor: Colors.grey.shade200,
                      inactiveTrackColor: Colors.grey,
                      splashRadius: 50.0,
                      value: forDeparture,
                      onChanged: (value) =>
                      setState((){
                        forDeparture = value;
                      })
                    ),
                  ),
                  SizedBox(height: 20.0),
                  listTiles(
                    onTap: (){},
                    title: "Arrival",
                    subTitle: "Scheduled arrival Changes",
                    container: Switch(
                      activeColor: ColorsTheme.primaryColor,
                      inactiveThumbColor: Colors.grey.shade200,
                      inactiveTrackColor: Colors.grey,
                      splashRadius: 50.0,
                      value: forArrival,
                      onChanged: (value) => setState(() => forArrival = value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget listTiles({
    required Function() onTap,
    required String title,
    required String subTitle,
    required Switch container,
  }){
    return  Container(
      color: ColorsTheme.lightGreyColor,
      child: ListTile(
        onTap: (){
          onTap();
        },
        tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          subTitle,
        ),
        trailing: container
      ),
    );
  }

}

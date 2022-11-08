// ignore_for_file: prefer_const_constructors

import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flutter/material.dart';

class AddMyFlightsScreen extends StatefulWidget {
  const AddMyFlightsScreen({Key? key}) : super(key: key);

  @override
  State<AddMyFlightsScreen> createState() => _AddMyFlightsScreenState();
}

class _AddMyFlightsScreenState extends State<AddMyFlightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Add Flights", style: ThemeTexts.textStyleTitle2
            .copyWith(fontWeight: FontWeight.normal)),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyFlightsScreen()));
          }, icon: Icon(Icons.check))
        ],
      ),
      body: Scaffold(
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/screen/add_myflights_screen.dart';
import 'package:flutter/material.dart';

class MyFlightsScreen extends StatefulWidget {
  const MyFlightsScreen({Key? key}) : super(key: key);

  @override
  State<MyFlightsScreen> createState() => _MyFlightsScreenState();
}

class _MyFlightsScreenState extends State<MyFlightsScreen> {

  TextEditingController createTripController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsTheme.myFlightsbg,
      appBar: AppBar(
        title: Text(
          "MY FLIGHTS",
          style: ThemeTexts.textStyleTitle2
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              myFlightsText(text: "My Trips", icon: Icons.kitchen),
              Row(
                children: [
                  createTrip(width: w,
                      onTap: () {
                    openDialogue();
                  }),
                ],
              ),
              myFlightsText(
                  text: "My Upcoming Flights", icon: Icons.flight_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget myFlightsText({
    required String text,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          Text(
            text,
            style: ThemeTexts.textStyleValueBlack.copyWith(letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  Widget createTrip({required double width,required Function() onTap}) {
    return InkWell(
      onTap: (){
        onTap();
    },
      child: SizedBox(
        height: width * 0.35,
        width: width * 0.35,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outlined,
                color: ColorsTheme.primaryColor,
                size: width * 0.1,
              ),
              SizedBox(height: 10),
              Text(
                "Create New Trip",
                style: ThemeTexts.textStyleTitle3.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Trip'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textFormFields(width: MediaQuery.of(context).size.width/2, hintText: "Enter Name", textController: createTripController),
            ],
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){return AddMyFlightsScreen();}));
            },
                child: Text('OK')),
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            },
                child: Text('CANCEL')),
          ],
        );
      });

  Widget textFormFields({
    required double width,
    required String hintText,
    required TextEditingController textController,
  }){
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: textController,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
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
    );
  }
}

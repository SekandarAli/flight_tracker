// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

class AirportScreenDetail extends StatefulWidget {
  const AirportScreenDetail({Key? key}) : super(key: key);

  @override
  State<AirportScreenDetail> createState() => _AirportScreenDetailState();
}

class _AirportScreenDetailState extends State<AirportScreenDetail> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: h * 0.25,
                width: w,
                child: Image.asset("assets/images/airport.jpg",fit: BoxFit.fill),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: h * 0.1,
                width: w,
                color: ColorsTheme.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lahore Airport",style: ThemeTexts.textStyleTitle2),
                    Text("Airport",style: ThemeTexts.textStyleTitle3),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: h * 0.2,
                width: w,
                color: ColorsTheme.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Local Time",style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
                            Text("Wed 02:56 PM",style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
                          ],
                        ),
                        Text("86 C",style: ThemeTexts.textStyleTitle1),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info),
                              Text("INFO",style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

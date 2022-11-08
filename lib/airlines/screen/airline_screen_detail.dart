// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_by_flightcode/search_tab_by_flightcode.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_by_route/search_tab_by_route.dart';
import 'package:flutter/material.dart';

class AirlineScreenDetails extends StatefulWidget {
  const AirlineScreenDetails({Key? key}) : super(key: key);

  @override
  State<AirlineScreenDetails> createState() => _AirlineScreenDetailsState();
}

class _AirlineScreenDetailsState extends State<AirlineScreenDetails>
    with SingleTickerProviderStateMixin {
  int index = 1;

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/airline.png'),
                      fit: BoxFit.fill),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,))
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                // height: h * 0.1,
                width: w,
                color: ColorsTheme.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Caspian Airline", style: ThemeTexts.textStyleTitle2),
                    SizedBox(height: 5),
                    Text("Airline", style: ThemeTexts.textStyleTitle3),
                  ],
                ),
              ),
              Container(
                // height: h * 0.2,
                width: w,
                color: ColorsTheme.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        container(icon: Icons.info, text: "INFO"),
                        container(
                            icon: Icons.sports_baseball_rounded,
                            text: "WEBSITE"),
                      ],
                    ),
                    Container(
                      color: ColorsTheme.primaryColor,
                      height: 15,
                    ),
                  ],
                ),
              ),
              Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("TIME"),
                              Text("DEP/ARR"),
                              Text("NR/STATE"),
                            ],
                          ),
                        ),
                        Container(
                          height: h * 0.7,
                          width: w,
                          child: ListView.builder(
                            padding: EdgeInsets.all(20),
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {},
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("11:06 AM"),
                                      Text("Dubai, DXB/Karachi, DVC"),
                                      Text("PK 247"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget container({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: ColorsTheme.primaryColor,
          ),
          SizedBox(height: 5),
          Text(text,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget selectTabs() {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ReusingWidgets().airlineTapBar(
              onTap: () {
                setState(() {
                  index = 2;
                });
              },
              context: context,
              text: "DEPARTURES",
              textColor: index == 2 ? ColorsTheme.primaryColor : Colors.grey,
              borderColor: index == 2 ? ColorsTheme.primaryColor : Colors.grey,
              borderWidth: index == 2 ? 3 : 1),
          ReusingWidgets().airlineTapBar(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              context: context,
              text: "ARRIVALS",
              textColor: index == 1 ? ColorsTheme.primaryColor : Colors.grey,
              borderColor: index == 1 ? ColorsTheme.primaryColor : Colors.grey,
              borderWidth: index == 1 ? 3 : 1),
        ],
      ),
    );
  }
}

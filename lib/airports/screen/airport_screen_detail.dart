// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/airports/screen/airport_track_flight.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

class AirportScreenDetail extends StatefulWidget {
   AirportScreenDetail({Key? key,required this.airportName}) : super(key: key);

   String airportName;

  @override
  State<AirportScreenDetail> createState() => _AirportScreenDetailState();
}

class _AirportScreenDetailState extends State<AirportScreenDetail> {

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
                      image: AssetImage('assets/images/airport.jpg'),
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
                    Text(widget.airportName, style: ThemeTexts.textStyleTitle2),
                    SizedBox(height: 5),
                    Text("Airport", style: ThemeTexts.textStyleTitle3),
                  ],
                ),
              ),
              Container(
                width: w,
                color: ColorsTheme.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Local Time",
                                  style: ThemeTexts.textStyleTitle2
                                      .copyWith(color: Colors.grey)),
                              Text("Wed 02:56 PM",
                                  style: ThemeTexts.textStyleTitle3
                                      .copyWith(color: Colors.grey)),
                            ],
                          ),
                          Text("86°F",
                              style: ThemeTexts.textStyleTitle1
                                  .copyWith(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        container(icon: Icons.info, text: "INFO"),
                        container(
                            icon: Icons.assistant_navigation, text: "NAV"),
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
              selectTabs(),
              index == 1
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("TIME           "),
                              Text("DESTINATION"),
                              Text("FLIGHT #"),
                            ],
                          ),
                        ),
                        Container(
                          height: h * 0.7,
                          child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return AirportTrackFlight();
                                  }));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("11:06 AM"),
                                      Text("Dubai, DXB"),
                                      Text("PK 247"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
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

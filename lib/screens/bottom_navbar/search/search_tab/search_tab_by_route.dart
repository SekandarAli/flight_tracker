// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/functions/date.dart';
import 'package:flight_tracker/screens/bottom_navbar/airports/airports_screen.dart';
import 'package:flutter/material.dart';

class SearchTabByRoute extends StatefulWidget {
  const SearchTabByRoute({Key? key}) : super(key: key);

  @override
  State<SearchTabByRoute> createState() => _SearchTabByRouteState();
}

class _SearchTabByRouteState extends State<SearchTabByRoute> {

  bool hideAdvance = false;

  var departureAirport = "Departure Airport";
  var arrivalAirport = "Arrival Airport";


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: ColorsTheme.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// BlUE CONTAINER
            Container(
              color: ColorsTheme.primaryColor,
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  ReusingWidgets.byRouteContainer(
                      context: context,
                      departureTitle: departureAirport,
                      arrivalTitle: arrivalAirport,
                    onTapDepartureTitle: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return AirportsScreen(title: "Search for an Airport");
                        }));
                    },
                    onTapArrivalTitle: () {  },
                  ),

                  SizedBox(height: 10),

                  PickDate(),

                  SizedBox(height: 10),

                  hideAdvance == true ? ReusingWidgets.optionalAirlineContainer(airlineTitle: "Airline(Optional)") : Container(),

                  ReusingWidgets.hideAirlineText(
                    text: hideAdvance == true ? 'HIDE ADVANCED' : "SHOW ADVANCED",
                    icon: hideAdvance == true ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    onTap: () {
                      setState(() {
                        hideAdvance = !hideAdvance;
                      });
                    },
                  ),

                  ReusingWidgets.searchButton(onPress: (){}, context: context),

                ],
              ),
            ),

            /// BlUE CONTAINER


            /// WHITE CONTAINER

            Container(
              color: ColorsTheme.white,
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 10),

                  Text("Recent Searches",style: TextStyle(
                      fontSize: 13,
                      color: ColorsTheme.textColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,),),

                  SizedBox(height: 10),


                ],
              ),
            ),

            /// WHITE CONTAINER

          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_date.dart';
import 'package:flight_tracker/functions/function_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'search_tab_departure_airport.dart';

class SearchTabByRoute extends StatefulWidget {
  const SearchTabByRoute({Key? key}) : super(key: key);

  @override
  State<SearchTabByRoute> createState() => _SearchTabByRouteState();
}

class _SearchTabByRouteState extends State<SearchTabByRoute> {

  bool hideAdvance = false;

  var departureAirport = "Departure Airport";
  var arrivalAirport = "Arrival Airport";

  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");
  }


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
                    onTapDepartureTitle: () async{

                      final List<dynamic> newValue = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SearchTabDepartureAirport();
                      }));

                      setState(() {
                        departureAirport = newValue[0];
                      });
                    },
                    onTapArrivalTitle: () async{
                      final List<dynamic> newValue = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SearchTabDepartureAirport();
                      }));

                      setState(() {
                        arrivalAirport = newValue[0];
                      });
                    },

                      context: context,
                      departureTitle: departureAirport,
                      arrivalTitle: arrivalAirport,
                      depStyle: departureAirport == "Departure Airport" ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
                      arrStyle: arrivalAirport == "Arrival Airport" ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
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

                  ReusingWidgets.searchButton(onPress: (){

                    setState((){
                      modelMyFlights = ModelSearch(
                          arrivalCity: arrivalAirport,
                          departureCity: departureAirport,
                      );

                      print("okay ${modelMyFlights!.arrivalCity}");
                      dataBox!.add(modelMyFlights!);
                    });
                  },
                      context: context),

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

                  SearchTabRecentSearches(),


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

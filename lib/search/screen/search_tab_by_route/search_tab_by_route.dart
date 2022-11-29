// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_date.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'search_button_by_route.dart';
import 'search_tab_airline_optional.dart';
import 'search_tab_arrival_departure_airport.dart';

class SearchTabByRoute extends StatefulWidget {
  const SearchTabByRoute({super.key});

  @override
  State<SearchTabByRoute> createState() => _SearchTabByRouteState();
}

class _SearchTabByRouteState extends State<SearchTabByRoute> {
  bool hideAdvance = false;

  // String departureAirportShortName = "KHI";
  String departureAirportShortName = "Departure Airport";
  // String arrivalAirportShortName= "LHE";
  String arrivalAirportShortName = "Arrival Airport";
  String airlineOptionalShortName = "Airline(Optional)";
  String airlineOptional = "Airline(Optional)";
  // String departureAirportName = "LHE";
  String departureAirportName = "Departure Airport";
  // String arrivalAirportName = "KHI";
  String arrivalAirportName = "Arrival Airport";


  List<dynamic>? departureValue;
  List<dynamic>? arrivalValue;

  var temp1;
  var temp2;

  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");
  }

  void swapValues(){
    // var temp = firstController.text.toString();
    setState((){
      // firstController.text = secondController.text.toString();
      // secondController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
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
                onTapDepartureTitle: () async {
                   departureValue = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchTabArrivalDepartureAirport();
                  }));

                  setState(() {
                    departureAirportShortName = departureValue![0];
                    departureAirportName = departureValue![1];

                    // print("departureAirportName$departureAirportName");
                    // print("departureAirportShortName$departureAirportShortName");

                  });
                },
                onTapArrivalTitle: () async {
                  arrivalValue = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                        return SearchTabArrivalDepartureAirport();
                  }));

                  setState(() {
                    arrivalAirportShortName = arrivalValue![0];
                    arrivalAirportName = arrivalValue![1];

                    // print("arrivalAirportName$arrivalAirportName");
                    // print("arrivalAirportShortName$arrivalAirportShortName");

                  });
                },
                context: context,
                departureTitle: departureAirportShortName,
                arrivalTitle: arrivalAirportShortName,
                depStyle: departureAirportShortName == "Departure Airport" || departureAirportShortName == "Arrival Airport"
                    ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
                arrStyle: arrivalAirportShortName == "Arrival Airport" || arrivalAirportShortName == "Departure Airport"
                    ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
                onTapClearDepartureTitle: (){
                  setState(() {
                    departureAirportShortName = "Departure Airport";
                  });
                },
                onTapClearArrivalTitle: (){
                  setState(() {
                    arrivalAirportShortName = "Arrival Airport";
                  });
                },
                clearIconDeparture: departureAirportShortName == "Departure Airport" || departureAirportShortName == "Arrival Airport"
                    ? false : true,
                clearIconArrival: arrivalAirportShortName == "Arrival Airport" || arrivalAirportShortName == "Departure Airport"
                    ? false : true,
                onTapSwapIcon: () {

                  temp1 = departureAirportShortName;
                  temp2 = departureAirportName;

                  setState((){
                    departureAirportShortName = arrivalAirportShortName;
                    departureAirportName = arrivalAirportName;

                    arrivalAirportShortName = temp1;
                    arrivalAirportName = temp2;

                  });

                  print(departureAirportShortName);
                  print(arrivalAirportShortName);

                },
              ),
              SizedBox(height: 10),
              PickDate(),
              SizedBox(height: 10),
              hideAdvance == true
                  ? ReusingWidgets.optionalAirlineContainer(
                airlineTitle: airlineOptional,
                context: context,
                onTapAirlineOptional: () async{
                  final List<dynamic> newValue = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchTabAirlineOptional();
                  }));

                  setState(() {
                    airlineOptional = newValue[0];
                    airlineOptionalShortName = newValue[1];
                  });
                },
                airlineStyle: airlineOptional == "Airline(Optional)" ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
              )
                  : Container(),
              ReusingWidgets.hideAirlineText(
                text:
                hideAdvance == true ? 'HIDE ADVANCED' : "SHOW ADVANCED",
                icon: hideAdvance == true
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                onTap: () {
                  setState(() {
                    hideAdvance = !hideAdvance;
                  });
                },
              ),
              ReusingWidgets.searchButton(
                  onPress: () {
                    setState(() {
                      /// If search don't exist
                      // showAlertDialog(context);

                      /// If search exist
                      if(departureAirportShortName == "Departure Airport" && arrivalAirportShortName == "Arrival Airport"){
                        ReusingWidgets().snackBar(context: context, text: 'Please Select Airport');
                      }
                      else {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          print("departureAirportShortName$departureAirportName");
                          print("arrivalAirportShortName$arrivalAirportName");

                          return SearchButtonByRoute(
                            departureAirport: departureAirportName,
                            arrivalAirport: arrivalAirportName,
                            airlineOptional: airlineOptional,
                          );
                        }));

                        modelMyFlights = ModelSearch(
                          arrivalCity: arrivalAirportShortName,
                          departureCity: departureAirportShortName,
                        );
                        // dataBox!.put("modelSearch",modelMyFlights!);
                        dataBox!.add(modelMyFlights!);
                      }
                    });
                  },
                  context: context,
                  text: 'SEARCH',
              ),
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
              Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 13,
                  color: ColorsTheme.textColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              SearchTabRecentSearches(),
            ],
          ),
        ),

        /// WHITE CONTAINER
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("No Flights Found"),
      content: Text("Try again or try searching by flight code.\n\n"
          "Hint: For connecting flights try to search for each leg separately."),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {Navigator.pop(context);},
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget flightDetails(
      {required String cityName,
        required String cityShortCode,
        required String cityTime,
        required CrossAxisAlignment crossAlignment}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAlignment,
      children: [
        Text("$cityName \n$cityShortCode",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
        SizedBox(height: 10),
      ],
    );
  }
}
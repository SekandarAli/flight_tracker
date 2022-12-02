// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_date.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
  // String arrivalAirportShortName= "LHE";
  // String departureAirportName = "LHE";
  // String arrivalAirportName = "KHI";
  String departureAirportShortName = "DPT";
  String arrivalAirportShortName = "ARR";
  String departureAirport = "Departure Airport";
  String arrivalAirport = "Arrival Airport";
  String airlineOptionalShortName = "AR";
  String airlineOptional = "Airline(Optional)";

  List<dynamic>? arrivalValue;
  List<dynamic>? departureValue;

  var temp1;
  var temp2;

  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;

  // var box = GetStorage();

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    // box.writeIfNull('departureAirportName', departureAirportName);
    // box.writeIfNull('departureAirportShortName', departureAirportShortName);

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
                    departureAirport = departureValue![0];
                    departureAirportShortName = departureValue![1];

                    // box.write('departureAirportName', departureAirportName);
                    // box.write('departureAirportShortName', departureAirportShortName);

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
                    arrivalAirport = arrivalValue![0];
                    arrivalAirportShortName = arrivalValue![1];

                    // print("arrivalAirportName$arrivalAirportName");
                    // print("arrivalAirportShortName$arrivalAirportShortName");

                  });
                },
                context: context,
                departureTitle: departureAirport,
                // departureTitle: '${box.read("departureAirportShortName")}',
                arrivalTitle: arrivalAirport,
                depStyle: departureAirport == "Departure Airport" || departureAirport == "Arrival Airport"
                    ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
                arrStyle: arrivalAirport == "Arrival Airport" || arrivalAirport == "Departure Airport"
                    ? ThemeTexts.textStyleValueGrey : ThemeTexts.textStyleValueBlack,
                onTapClearDepartureTitle: (){
                  setState(() {
                    departureAirport = "Departure Airport";
                  });
                },
                onTapClearArrivalTitle: (){
                  setState(() {
                    arrivalAirport = "Arrival Airport";
                  });
                },
                clearIconDeparture: departureAirport == "Departure Airport" || departureAirport == "Arrival Airport"
                    ? false : true,
                clearIconArrival: arrivalAirport == "Arrival Airport" || arrivalAirport == "Departure Airport"
                    ? false : true,
                onTapSwapIcon: () {

                  temp1 = departureAirport;
                  temp2 = departureAirportShortName;

                  setState((){
                    departureAirport = arrivalAirport;
                    departureAirportShortName = arrivalAirportShortName;

                    arrivalAirport = temp1;
                    arrivalAirportShortName = temp2;

                  });

                  print(departureAirport);
                  print(arrivalAirport);

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
                      if(departureAirport == "Departure Airport" && arrivalAirport == "Arrival Airport"){
                        ReusingWidgets().snackBar(context: context, text: 'Please Select Airport');
                      }
                      else {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          print("departureAirportShortName$departureAirportShortName");
                          print("arrivalAirportShortName$arrivalAirportShortName");

                          return SearchButtonByRoute(
                            departureAirport: departureAirportShortName,
                            arrivalAirport: arrivalAirportShortName,
                            airlineOptional: airlineOptional,
                          );
                        }));

                        modelMyFlights = ModelSearch(
                          arrivalCity: arrivalAirport,
                          departureCity: departureAirport,
                          arrivalCityShortName: arrivalAirportShortName,
                          departureCityShortName: departureAirportShortName
                        );
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
              // SearchTabRecentSearches(
              //   departureAirport: departureAirport,
              //   departureAirportShortName: departureAirportShortName,
              //   arrivalAirport: arrivalAirport,
              //   arrivalAirportShortName: arrivalAirportShortName,
              // ),
              SizedBox(
                height: h * 0.4,
                width: w,
                child: ValueListenableBuilder<Box<ModelSearch>>(
                  valueListenable:
                  Hive.box<ModelSearch>("modelSearch").listenable(),
                  builder: (context, box, _) {
                    final items = box.values.toList().cast<ModelSearch>();

                    if (items.isEmpty) {
                      return Container();
                    } else {
                      return Flex(
                          direction: Axis.vertical,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: box.values.length,
                                itemBuilder: (context, index) {
                                  ModelSearch? currentTask = box.getAt(index);
                                  return Container(
                                    width: w,
                                    padding: EdgeInsets.only(left: 6,bottom: 6),
                                    margin: EdgeInsets.only(left: 6,bottom: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              departureAirport = currentTask.departureCity!;
                                              departureAirportShortName = currentTask.departureCityShortName!;
                                              arrivalAirport = currentTask.arrivalCity!;
                                              arrivalAirportShortName = currentTask.arrivalCityShortName!;
                                            });
                                          },
                                          child: SizedBox(
                                            width: w * 0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.history,color: Colors.grey,),
                                                SizedBox(width: 10,),
                                                Flexible(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(color: Colors.black, fontSize: 60),
                                                      children: [
                                                        TextSpan(text: 'From  ',style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.normal,fontFamily: "OpenSansRegular")),
                                                        TextSpan(text: currentTask!.departureCity, style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                                        TextSpan(text: '  to  ',style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.normal,fontFamily: "OpenSansRegular")),
                                                        TextSpan(text: currentTask.arrivalCity, style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                                      ],
                                                    ),
                                                    textScaleFactor: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(icon: Icon(Icons.clear),color: Colors.grey,
                                          onPressed: (){
                                            currentTask.delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),]
                      );
                    }
                  },
                ),
              ),
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
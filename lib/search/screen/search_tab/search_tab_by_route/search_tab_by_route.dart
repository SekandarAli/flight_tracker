// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_date.dart';
import 'package:flight_tracker/search/model/model_search_flights.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_by_route/search_button.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
import 'package:flight_tracker/search/services/services_search_flight.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'search_tab_arrival_departure_airport.dart';

class SearchTabByRoute extends StatefulWidget {
  // const SearchTabByRoute({Key? key}) : super(key: key);

  @override
  State<SearchTabByRoute> createState() => _SearchTabByRouteState();
}

class _SearchTabByRouteState extends State<SearchTabByRoute> {
  bool hideAdvance = false;

  var departureAirport = "Taiyuan";
  var arrivalAirport = "Hangzhou";

  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;

  Future<ModelSearchFlights>? futureList;

  // String? flightCode;
  // var flightStatus;
  // String? departureCity;
  // String? arrivalCity;
  // String? departureCityShortName;
  // String? arrivalCityShortName;
  // var departureCityTime;
  // var arrivalCityTime;


  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");

    futureList = ServicesSearchFlights().GetAllPosts();
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
                    onTapDepartureTitle: () async {
                      final List<dynamic> newValue = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SearchTabArrivalDepartureAirport();
                      }));

                      setState(() {
                        departureAirport = newValue[0];
                      });
                    },
                    onTapArrivalTitle: () async {
                      final List<dynamic> newValue = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SearchTabArrivalDepartureAirport();
                      }));

                      setState(() {
                        arrivalAirport = newValue[0];
                      });
                    },
                    context: context,
                    departureTitle: departureAirport,
                    arrivalTitle: arrivalAirport,
                    depStyle: departureAirport == "Departure Airport"
                        ? ThemeTexts.textStyleValueGrey
                        : ThemeTexts.textStyleValueBlack,
                    arrStyle: arrivalAirport == "Arrival Airport"
                        ? ThemeTexts.textStyleValueGrey
                        : ThemeTexts.textStyleValueBlack,
                  ),
                  SizedBox(height: 10),
                  PickDate(),
                  SizedBox(height: 10),
                  hideAdvance == true
                      ? ReusingWidgets.optionalAirlineContainer(
                          airlineTitle: "Airline(Optional)")
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

                          modelMyFlights = ModelSearch(
                            arrivalCity: arrivalAirport,
                            departureCity: departureAirport,
                          );
                          dataBox!.add(modelMyFlights!);

                          /// If search don't exist
                          // showAlertDialog(context);

                          /// If search exist
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return SearchButtonScreen(departureAirport: departureAirport,arrivalAirport: arrivalAirport,);
                          }));
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
                  // SizedBox(
                  //   height: h * 0.5,
                  //   width: w,
                  //   child: FutureBuilder(
                  //     future: futureList,
                  //     builder: (context,snapshot) {
                  //       if (snapshot.hasData) {
                  //         if (snapshot.data!.response!.isNotEmpty) {
                  //           return Container(
                  //             color: Colors.white,
                  //             child: Column(
                  //               children: [
                  //                 Flexible(
                  //                   child: ListView.builder(
                  //                     padding: EdgeInsets.all(5),
                  //                     itemCount: snapshot.data!.response!.length,
                  //                     itemBuilder: (context, index) {
                  //                       // String? flightCode = snapshot.data!.data![index].flight!.number ?? "Unknown";
                  //                       // var flightStatus = snapshot.data!.data![index].flightStatus ?? "Unknown";
                  //                       // String? departureCity = snapshot.data!.data![index].departure!.airport ?? "Unknown";
                  //                       // String? arrivalCity = snapshot.data!.data![index].arrival!.airport ?? "Unknown";
                  //                       // String? departureCityShortName = snapshot.data!.data![index].departure!.iata ?? "Unknown";
                  //                       // String? arrivalCityShortName = snapshot.data!.data![index].arrival!.iata ?? "Unknown";
                  //                       // var departureCityTime = snapshot.data!.data![index].flightDate ?? "Unknown";
                  //                       // var arrivalCityTime = snapshot.data!.data![index].flightDate ?? "Unknown";
                  //
                  //                       flightCode = snapshot.data!.response![index].flightNumber ?? "Unknown";
                  //                       flightStatus = snapshot.data!.response![index].status ?? "Unknown";
                  //                       departureCity = snapshot.data!.response![index].depIata ?? "Unknown";
                  //                       arrivalCity = snapshot.data!.response![index].arrIata ?? "Unknown";
                  //                       departureCityShortName = snapshot.data!.response![index].depIcao ?? "Unknown";
                  //                       arrivalCityShortName = snapshot.data!.response![index].arrIcao ?? "Unknown";
                  //                       departureCityTime = snapshot.data!.response![index].lat ?? "Unknown";
                  //                       arrivalCityTime = snapshot.data!.response![index].lng ?? "Unknown";
                  //
                  //                       print("departureairport $departureAirport");
                  //                       print("departurecity $departureCity");
                  //                       print("arrivalcity $arrivalCity");
                  //
                  //                       return
                  //                         departureAirport == departureCity && arrivalAirport == arrivalCity ?
                  //                         InkWell(
                  //                             onTap: ()  {},
                  //                             child:  Card(
                  //                               child: Column(
                  //                                 children: [
                  //                                   Container(
                  //                                     padding: EdgeInsets.all(15),
                  //                                     color: ColorsTheme.primaryColor,
                  //                                     child: Row(
                  //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                       children: [
                  //                                         Text(flightCode!, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
                  //                                         Text(flightStatus.toString(),
                  //                                         style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white))
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                                   Padding(
                  //                                     padding: EdgeInsets.all(15),
                  //                                     child: Row(
                  //                                       mainAxisAlignment:
                  //                                       MainAxisAlignment.spaceBetween,
                  //                                       children: [
                  //
                  //                                         flightDetails(
                  //                                             cityName: departureCity!,
                  //                                             cityShortCode: departureCityShortName!,
                  //                                             cityTime: departureCityTime.toString(),
                  //                                             crossAlignment: CrossAxisAlignment.start,
                  //                                         ),
                  //
                  //                                         Icon(Icons.flight_land_rounded, size: 30),
                  //
                  //                                         flightDetails(
                  //                                             cityName: arrivalCity!,
                  //                                             cityShortCode: arrivalCityShortName!,
                  //                                             cityTime: arrivalCityTime.toString(),
                  //                                             crossAlignment: CrossAxisAlignment.end,
                  //                                         ),
                  //
                  //                                       ],
                  //                                     ),
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //
                  //                         )
                  //                       : Container();
                  //                     },
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         } else {
                  //           return Center(
                  //             child: Text(
                  //               "error 1${snapshot.error}",
                  //             ),
                  //           );
                  //         }
                  //       } else if (snapshot.hasError) {
                  //         // return Center(
                  //         //   child: Text(
                  //         //     "error 2${snapshot.error}",
                  //         //   ),
                  //         // );
                  //         return SearchTabRecentSearches();
                  //       } else {
                  //         return Center(child: FunctionProgressIndicator());
                  //       }
                  //     },
                  //
                  //   ),
                  // ),

                ],
              ),
            ),

            /// WHITE CONTAINER
          ],
        ),
      ),
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

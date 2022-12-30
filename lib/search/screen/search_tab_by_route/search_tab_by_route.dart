// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../../model/model_search_flight.dart';
import '../../services/services_search_flight.dart';
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
  String departureAirportShortName = "Departure";
  String arrivalAirportShortName = "Arrival";
  String departureAirport = "DPT Airport";
  String arrivalAirport = "ARR Airport";
  String airlineOptionalShortName = "AR";
  String airlineOptional = "Airline(Optional)";
  var temp1;
  var temp2;
  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;
  String depIata = "Departure";
  String arrIata = "Arrival";
  String airlineIcao = "";
  var dateDay;
  DateTime selectedDate = DateTime.now();
  var currentDate;

  Future<ModelSearchFlight>? futureList;

  TextEditingController departureAirport1 = TextEditingController();
  TextEditingController arrivalAirport1 = TextEditingController();
  TextEditingController depIata1 = TextEditingController();
  TextEditingController arrIata1 = TextEditingController();
  TextEditingController departureAirportShortName1 = TextEditingController();
  TextEditingController arrivalAirportShortName1 = TextEditingController();

  TextEditingController airlineOptional1 = TextEditingController();
  TextEditingController airlineOptionalShortName1 = TextEditingController();
  TextEditingController airlineIcao1 = TextEditingController();


  bool trackFlight = true;
  bool cardExpand = false;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");
    dateDay = DateFormat('EEEE').format(selectedDate).substring(0,3).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    currentDate = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    print("object2");


    return Column(
      children: [
        /// WHITE CONTAINER
        Container(
          color:  ColorsTheme.primaryColor,
          child: Container(
            decoration: ReusingWidgets().curveDecorationContainer(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter mySetState) {
                          return ReusingWidgets.byRouteNewContainer(

                            airportName1: departureAirport1,
                            // airportName1: departureAirport1.text.length > 12 ? "departureAirport1.text.length == 12" : " departureAirport1.text",
                            airportShortName1: depIata1,
                            title2: "DPT Airport",


                            sizedBoxHeight: 0,
                            context: context,
                            title1: 'From',
                            airportName: departureAirport,
                            airportShortName: "($depIata)",
                            crossAxisAlignment: CrossAxisAlignment.start,
                            onTapAirport: () async{
                              List<dynamic> newValue = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SearchTabArrivalDepartureAirport();
                              }));


                              mySetState(() {
                                departureAirport = newValue[0];
                                departureAirportShortName = newValue[1];
                                depIata = newValue[2];



                                departureAirport1.text = newValue[0];
                                departureAirportShortName1.text = newValue[1];
                                depIata1.text = newValue[2];
                              });
                            },
                          );
                        }
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Image.asset("assets/images/flightIcon.png",width:  w * 0.22,height:  w * 0.15,),
                    ),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter mySetState) {
                          return ReusingWidgets.byRouteNewContainer(

                            airportName1: arrivalAirport1,
                            airportShortName1: arrIata1,
                            title2: "ARR Airport",


                            context: context,
                            title1: 'To',
                            airportName: arrivalAirport,
                            airportShortName: "($arrIata)",
                            crossAxisAlignment: CrossAxisAlignment.end,
                            onTapAirport: () async{
                              List<dynamic> newValue = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SearchTabArrivalDepartureAirport();
                              }));

                              mySetState(() {
                                arrivalAirport = newValue[0];
                                arrivalAirportShortName = newValue[1];
                                arrIata = newValue[2];


                                arrivalAirport1.text = newValue[0];
                                arrivalAirportShortName1.text = newValue[1];
                                arrIata1.text = newValue[2];
                              });
                            },
                          );
                        }
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
                        ),
                        SizedBox(height: 5),
                        StatefulBuilder(
                            builder: (BuildContext context, StateSetter mySetState) {
                              return InkWell(
                                onTap: () {
                                  selectDate(context,mySetState);
                                },
                                child:  Row(
                                  children: [
                                    Icon(Icons.calendar_month, color: ColorsTheme.textColor),
                                    SizedBox(width: 1),
                                    Text(
                                      "${dateDay.toUpperCase()},${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                                      style: ThemeTexts.textStyleValueGrey,
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                        ReusingWidgets.divider(context: context),
                      ],
                    ),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter mySetState) {
                          return ReusingWidgets.byRouteAirlineNewContainer(

                             airlineName1: airlineOptional1,
                             airlineShortName1: airlineIcao1,


                              airlineName: airlineOptional,
                              airlineShortName: airlineIcao,
                              context: context,
                              onTapAirline: () async{
                                final List<dynamic> newValue = await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SearchTabAirlineOptional();
                                }));

                                mySetState(() {
                                  airlineOptional = newValue[0];
                                  airlineOptionalShortName = newValue[1];
                                  airlineIcao = newValue[2];


                                  airlineOptional1.text = newValue[0];
                                  airlineOptionalShortName1.text = newValue[1];
                                  airlineIcao1.text = newValue[2];

                                });
                              });
                        }
                    ),

                  ],
                ),

                SizedBox(height: 30),
                ReusingWidgets.searchButton(
                  onPress: () {

                    /// If search exist
                    if(departureAirport == "DPT Airport"){
                      ReusingWidgets().snackBar(context: context, text: 'Please Select Departure Airport');
                    }
                    else if(arrivalAirport == "ARR Airport")
                    {
                      ReusingWidgets().snackBar(context: context, text: 'Please Select Arrival Airport');
                    }
                    else {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //   print("departureAirportShortName$depIata");
                      //   print("arrivalAirportShortName$arrIata");
                      //   print("airlineOptional$airlineIcao");
                      //   print("dayDate$dateDay");
                      //
                      //   return SearchButtonByRoute(
                      //     depIata: depIata1.text,
                      //     arrIata: arrIata1.text,
                      //     airlineOptional: airlineIcao,
                      //     dateDay: dateDay,
                      //     currentDate: currentDate,
                      //     departureAirport: departureAirport,
                      //     arrivalAirport: arrivalAirport,
                      //   );
                      // }));


                      modelMyFlights = ModelSearch(
                          arrivalCity: arrivalAirport,
                          departureCity: departureAirport,
                          arrivalCityShortName: arrIata,
                          departureCityShortName: depIata,
                          flightCode: ""
                      );

                      setState(() {
                        futureList = ServicesSearchFlight().GetAllPosts(
                          depIata: depIata1.text,
                          arrIata: arrIata1.text,
                          airlineIcao: airlineOptional1.text,
                          day: dateDay,
                          flightIata: "",
                        );
                      });


                      // print("departureAirportShortName${depIata1.text}");
                      // print("arrivalAirportShortName${arrIata1.text}");
                      // print("airlineOptional$airlineIcao");
                      // print("dayDate$dateDay");


                      Future.delayed(Duration(milliseconds: 700)).then((value) => dataBox!.add(modelMyFlights!));
                    }
                  },
                  context: context,
                  text: 'SEARCH', style: ThemeTexts.textStyleTitle2,
                ),
              ],
            ),
          ),
        ),

        ///Future Builder Starts


        SizedBox(
          height: 0,
          width: w,
          child: FutureBuilder(
            future: futureList,
            builder: (context,snapshot) {
              print("future2");
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  log("hasData");
                  if (snapshot.data!.response == null) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                              padding: EdgeInsets.all(5),
                              itemCount: 1,
                              itemBuilder: (context, index) {

                                log( "${snapshot.data!.response!.length}");
                                log("notnull");
                                Future(() {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog(
                                            title: Text("No Flights Found"),
                                            content: Text(
                                                "Try again or try searching by flight code.\n\n"
                                                    "Hint: For connecting flights try to search for each leg separately."),
                                            actions: [
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ));
                                });
                                return Container();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  else {
                    log("null");
                    Future(() async {
                      await
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              SearchButtonByRoute(
                                depIata: depIata1.text,
                                arrIata: arrIata1.text,
                                airlineOptional: airlineIcao1.text,
                                dateDay: dateDay,
                                currentDate: currentDate,
                                departureAirport: departureAirport1.text,
                                arrivalAirport: arrivalAirport1.text,
                              )
                      ));
                    });
                    return Container();


                  }


                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "error 2${snapshot.error}",
                    ),
                  );
                } else {
                  return Center(child: FunctionProgressIndicator());
                }
              }
              else {
                return Container();
              }
            },

          ),
        ),

        /// Recent Searches Starts
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
                  color: ColorsTheme.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              ValueListenableBuilder<Box<ModelSearch>>(
                valueListenable:
                Hive.box<ModelSearch>("modelSearch").listenable(),
                builder: (context, box, _) {
                  final items = box.values.toList().cast<ModelSearch>();

                  if (items.isEmpty) {
                    return NoSearchFound();
                  } else {
                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        ModelSearch? currentTask = box.getAt(index);
                        return
                          currentTask!.departureCity!.isNotEmpty ?
                          Card(
                            color: ColorsTheme.lightGreenPrimary,
                            elevation: 5,
                            child: Container(
                              width: w,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  StatefulBuilder(
                                      builder: (BuildContext context, StateSetter mySetState) {
                                        return GestureDetector(
                                          onTap: (){
                                            print("ontaoppp");
                                            log(depIata.toString());
                                            log(depIata1.toString());
                                            mySetState(() {


                                              departureAirport = currentTask.departureCity!;
                                              depIata = currentTask.departureCityShortName!;
                                              arrivalAirport = currentTask.arrivalCity!;
                                              arrIata = currentTask.arrivalCityShortName!;


                                              departureAirport1.text = currentTask.departureCity!;
                                              depIata1.text = currentTask.departureCityShortName!;
                                              arrivalAirport1.text = currentTask.arrivalCity!;
                                              arrIata1.text = currentTask.arrivalCityShortName!;


                                              log("aa$depIata");
                                              log("aa$depIata1");
                                              log("aa$arrIata1");
                                            });
                                          },
                                          child: SizedBox(
                                            width: w * 0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.history,color: ColorsTheme.primaryColor,),
                                                SizedBox(width: 10,),
                                                Row(
                                                  children: [
                                                    Text(
                                                      // "${currentTask!.departureCityShortName}   ",
                                                        currentTask.departureCity!.length > 9 ? '${currentTask.departureCity!.substring(0, 9)}...  ' : "${currentTask.departureCity!}\t",

                                                        style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular",fontSize: 12)),
                                                    Icon(Icons.flight_takeoff,color: ColorsTheme.themeColor,),
                                                    Text(
                                                      // "   ${currentTask.arrivalCityShortName}",
                                                        currentTask.arrivalCity!.length > 9 ? '  ${currentTask.arrivalCity!.substring(0, 9)}...  ' : "\t${currentTask.arrivalCity!}",
                                                        style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),

                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                  IconButton(icon: Icon(Icons.clear),color: Colors.grey,
                                    onPressed: (){
                                      currentTask.delete();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                              : Container();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        /// Recent Searches Ends
        /// WHITE CONTAINER
      ],
    );
  }

  selectDate(BuildContext context,StateSetter mySetState) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(2022,12,28),
      lastDate: DateTime(2023,12,12),
      helpText: "Flight Track Date",
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (selected != null && selected != selectedDate) {
      mySetState(() {
        selectedDate = selected;
        print(DateFormat('EEEE').format(selectedDate).substring(0,3));
        dateDay = DateFormat('EEEE').format(selectedDate).substring(0,3).toLowerCase();
      });
    }
  }

}
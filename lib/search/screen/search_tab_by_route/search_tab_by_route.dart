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
import '../../../generated/assets.dart';
import '../../model/model_search_flight.dart';
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
  String airlineOptional = "Airline(OPT)";
  String temp1 = "";
  String temp2 = "";
  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;
  String depIata = "Departure";
  String arrIata = "Arrival";
  String airlineIcao = "";
  var dateDay;
  DateTime selectedDate = DateTime.now();
  var currentDate;

  Future<ModelSearchFlight>? futureList;
  bool trackFlight = true;
  bool cardExpand = false;


  // TextEditingController departureAirport1 = TextEditingController();
  // TextEditingController arrivalAirport1 = TextEditingController();
  // TextEditingController depIata1 = TextEditingController();
  // TextEditingController arrIata1 = TextEditingController();
  // TextEditingController departureAirportShortName1 = TextEditingController();
  // TextEditingController arrivalAirportShortName1 = TextEditingController();

  // TextEditingController airlineOptional1 = TextEditingController();
  // TextEditingController airlineOptionalShortName1 = TextEditingController();
  // TextEditingController airlineIcao1 = TextEditingController();


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
          // color:  Colors.transparent,
          child: Container(
            decoration: ReusingWidgets().curveDecorationContainer(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter mySetState) {
                          return ReusingWidgets.byRouteContainer(

                            // airportName1: departureAirport1,
                            // airportName1: departureAirport1.text.length > 12 ? "departureAirport1.text.length == 12" : " departureAirport1.text",
                            // airportShortName1: depIata1,
                            title2: "DPT Airport",
                            textAlign: TextAlign.start,
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


                              setState(() {
                                departureAirport = newValue[0];
                                departureAirportShortName = newValue[1];
                                depIata = newValue[2];



                                // departureAirport1.text = newValue[0];
                                // departureAirportShortName1.text = newValue[1];
                                // depIata1.text = newValue[2];
                              });
                            },
                          );
                        }
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      // color: Colors.green,
                      child: Column(
                        children: [
                          // IconButton(onPressed: (){
                          //   temp1 = departureAirport;
                          //   temp2 = depIata;
                          //
                          //   setState((){
                          //     departureAirport = arrivalAirport;
                          //     depIata = arrIata;
                          //
                          //     arrivalAirport = temp1;
                          //     arrIata = temp2;
                          //
                          //   });
                          //
                          // }, icon: Icon(Icons.swap_horiz,color: ColorsTheme.themeColor,size: 50,)),
                          // Image.asset("assets/images/flightIcon.png",width:  w * 0.22,height:  w * 0.15,),
                          departureAirport == "DPT Airport" || arrivalAirport == "ARR Airport" ?
                          Image.asset(Assets.imagesSwapImage,width:  w * 0.22,height:  w * 0.15) :
                          InkWell(onTap: (){
                            temp1 = departureAirport;
                            temp2 = depIata;

                            setState((){
                              departureAirport = arrivalAirport;
                              depIata = arrIata;
                              arrivalAirport = temp1;
                              arrIata = temp2;
                            });
                          },
                          child: Image.asset(Assets.imagesSwapImage,width:  w * 0.22,height:  w * 0.15)),
                        ],
                      ),
                    ),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter mySetState) {
                          return ReusingWidgets.byRouteContainer(

                            // airportName1: arrivalAirport1,
                            // airportShortName1: arrIata1,
                            title2: "ARR Airport",


                            context: context,
                            title1: 'To',
                            airportName: arrivalAirport,
                            airportShortName: "($arrIata)",
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textAlign: TextAlign.end,
                            onTapAirport: () async{
                              List<dynamic> newValue = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SearchTabArrivalDepartureAirport();
                              }));

                              setState(() {
                                arrivalAirport = newValue[0];
                                arrivalAirportShortName = newValue[1];
                                arrIata = newValue[2];


                                // arrivalAirport1.text = newValue[0];
                                // arrivalAirportShortName1.text = newValue[1];
                                // arrIata1.text = newValue[2];
                              });
                            },
                          );
                        }
                    ),
                  ],
                ),

                SizedBox(height: 0),
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
                        SizedBox(height: 10),
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
                          return ReusingWidgets.byRouteAirlineContainer(

                             // airlineName1: airlineOptional1,
                             // airlineShortName1: airlineIcao1,


                              airlineName: airlineOptional,
                              airlineShortName: airlineIcao,
                              context: context,
                              onTapClear: (){
                                setState(() {
                                  airlineOptional = "Airline(OPT)";
                                  airlineIcao = "";
                                });
                              },
                              clearIcon: airlineOptional == "Airline(OPT)" ? false : true,
                              onTapAirline: () async{
                                final List<dynamic> newValue = await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SearchTabAirlineOptional();
                                }));

                                mySetState(() {
                                  airlineOptional = newValue[0];
                                  airlineOptionalShortName = newValue[1];
                                  airlineIcao = newValue[2];


                                  // airlineOptional1.text = newValue[0];
                                  // airlineOptionalShortName1.text = newValue[1];
                                  // airlineIcao1.text = newValue[2];

                                });
                              });
                        }
                    ),

                  ],
                ),

                SizedBox(height: 30),
                ReusingWidgets.searchButton(

                  context: context,
                  // text: isLoading?  CircularProgressIndicator(color: Colors.white) : Text('SEARCH'),
                  text: 'SEARCH',
                  style: ThemeTexts.textStyleTitle2,
                  onPress: () {
                    Iterable hiveDepartureAirport =  Hive.box<ModelSearch>("modelSearch").values.map((e) => e.departureCity);
                    Iterable hiveArrivalAirport =  Hive.box<ModelSearch>("modelSearch").values.map((e) => e.arrivalCity);
                    var index = -1;
                    if(departureAirport == "DPT Airport" && arrivalAirport == "ARR Airport"){
                      ReusingWidgets().snackBar(context: context, text: 'Please Select Departure & Arrival Airport');
                    }
                    else if(departureAirport == "DPT Airport"){
                      ReusingWidgets().snackBar(context: context, text: 'Please Select Departure Airport');
                    }
                    else if(arrivalAirport == "ARR Airport") {
                      ReusingWidgets().snackBar(context: context, text: 'Please Select Arrival Airport');
                    }
                    else if(arrivalAirport == departureAirport) {
                      ReusingWidgets().snackBar(context: context, text: 'Departure and Arrival Airport are Same');
                    }


                    else if(hiveDepartureAirport.contains(departureAirport) && hiveArrivalAirport.contains(arrivalAirport)) {
                      for (int i = 0; i < dataBox!.length; i++) {
                        if (dataBox!.values.elementAt(i).departureCityShortName == depIata && dataBox!.values.elementAt(i).arrivalCityShortName == arrIata) {
                          index = i;
                        }
                      }
                      if (index != -1) {
                        ReusingWidgets().snackBar(context: context, text: "Searching Please Wait!");
                        dataBox!.deleteAt(index);

                        modelMyFlights = ModelSearch(
                            arrivalCity: arrivalAirport,
                            departureCity: departureAirport,
                            arrivalCityShortName: arrIata,
                            departureCityShortName: depIata,
                            flightCode: ""
                        );

                        Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return SearchButtonByRoute(
                              depIata: depIata,
                              arrIata: arrIata,
                              arrivalAirport: arrivalAirport,
                              departureAirport: departureAirport,
                              airlineOptional: airlineIcao,
                              dateDay: dateDay,
                              currentDate: currentDate,
                            );
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ));

                        Future.delayed(Duration(seconds: 2)).then((value) => dataBox!.add(modelMyFlights!));
                      }
                      else {
                        print("element not found");
                      }
                    }
                    else {
                      ReusingWidgets().snackBar(context: context, text: "Searching Please Wait!");
                      modelMyFlights = ModelSearch(
                          arrivalCity: arrivalAirport,
                          departureCity: departureAirport,
                          arrivalCityShortName: arrIata,
                          departureCityShortName: depIata,
                          flightCode: ""
                      );

                      Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return SearchButtonByRoute(
                              depIata: depIata,
                              arrIata: arrIata,
                              arrivalAirport: arrivalAirport,
                              departureAirport: departureAirport,
                              airlineOptional: airlineIcao,
                              dateDay: dateDay,
                              currentDate: currentDate,
                            );
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                      Future.delayed(Duration(seconds: 2)).then((value) => dataBox!.add(modelMyFlights!));
                    }
                  },
                ),
              ],
            ),
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
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        ModelSearch? currentTask = box.getAt(index);
                        return
                          currentTask!.departureCity!.isNotEmpty ?
                          Card(
                            color: ColorsTheme.lightGreyColor,
                            elevation: 5,
                            child: Container(
                              width: w,
                              padding: EdgeInsets.all(5),
                              // margin: EdgeInsets.all(5),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: StatefulBuilder(
                                        builder: (BuildContext context, StateSetter mySetState) {
                                          return GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                departureAirport = currentTask.departureCity!;
                                                depIata = currentTask.departureCityShortName!;
                                                arrivalAirport = currentTask.arrivalCity!;
                                                arrIata = currentTask.arrivalCityShortName!;
                                                // departureAirport = currentTask.departureCity!;
                                                // depIata = currentTask.departureCityShortName!;
                                                // arrivalAirport = currentTask.arrivalCity!;
                                                // arrIata = currentTask.arrivalCityShortName!;
                                                log("aa$depIata");
                                                log("aa$arrIata");
                                              });
                                            },
                                            child: Container(
                                              // color: Colors.green,
                                              // width: w * 0.7,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.history,color: ColorsTheme.primaryColor,),
                                                  SizedBox(width: 10),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.28,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          // currentTask.departureCity!.length > 10 ? '${currentTask.departureCity!.substring(0, 10)}...' : "${currentTask.departureCity!}\t",
                                                            "${currentTask.departureCity!}\t",
                                                            // style: ThemeTexts.textStyleValueBlack2),
                                                            style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                                        // SizedBox(height: 5),
                                                        // Text(
                                                        //     currentTask.departureCityShortName!,
                                                        //     style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular",fontSize: 14)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Icon(Icons.flight_takeoff,color: ColorsTheme.themeColor,)),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.28,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                            "${currentTask.arrivalCity!}\t",textAlign: TextAlign.end,
                                                            // currentTask.arrivalCity!.length > 10 ? '  ${currentTask.arrivalCity!.substring(0, 10)}...' : "\t${currentTask.arrivalCity!}",
                                                            style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular"))
                                                            // style: ThemeTexts.textStyleValueBlack2),
                                                        // SizedBox(height: 5),
                                                        // Text(
                                                        //     currentTask.arrivalCityShortName!,
                                                        //     style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular",fontSize: 14)),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.clear),color: Colors.grey,
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
      firstDate: DateTime.utc(2023,01,01),
      lastDate: DateTime(2024,01,01),
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
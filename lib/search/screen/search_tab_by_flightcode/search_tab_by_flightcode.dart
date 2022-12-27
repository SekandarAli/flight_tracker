// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/flight_detail/model/model_airport_track_screen.dart';
import 'package:flight_tracker/flight_detail/services/services_airports_track_screen.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/search/screen/search_tab_by_flightcode/search_button_by_flight_code.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class SearchTabByFlightCode extends StatefulWidget {
  const SearchTabByFlightCode({super.key});

  @override
  State<SearchTabByFlightCode> createState() => _SearchTabByFlightCodeState();
}

class _SearchTabByFlightCodeState extends State<SearchTabByFlightCode> {


  TextEditingController flightCodeController = TextEditingController();
  // Rx<TextEditingController> flightCodeController2 = TextEditingController().obs;

  Box<ModelSearch>? dataBoxSearch;
  ModelSearch? modelMyFlightsSearch;
  var dateDay;
  DateTime selectedDate = DateTime.now();


  Future<ModelAirportTrackScreen>? futureList;

  bool cardExpand = false;
  bool trackFlight = true;

  String flightCode = "---";
  String departureCityDate = '---';
  String departureCity = "---";
  String departureCityShortCode = "---";
  String departureCityTime = '---';
  String arrivalCity = "---";
  String arrivalCityShortCode = "---";
  String arrivalCityTime = "---";
  String arrivalCityDate = '---';
  String flightStatus = "---";

  var currentDate;


  @override
  void initState() {
    super.initState();
    dataBoxSearch = Hive.box<ModelSearch>("modelSearch");
    dateDay = DateFormat('EEEE').format(selectedDate).substring(0,3).toLowerCase();
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    currentDate = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    print("object");
    return Column(
      children: [

        /// White CONTAINER
        Container(
          color:  ColorsTheme.primaryColor,
          child: Container(
            decoration: ReusingWidgets().curveDecorationContainer(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter mySetState) {
                      return ReusingWidgets.byFlightCodeNewContainer(
                        context: context,
                        onTapClearIcon: () {
                          mySetState(() {
                            flightCodeController.clear();
                          });
                        },
                        textEditingController: flightCodeController,
                        clearIcon: flightCodeController.text.isEmpty ? Icons.clear : Icons.clear,
                      );
                    }
                ),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter mySetState) {
                      return InkWell(
                        onTap: () {
                          selectDate(context,mySetState);
                        },

                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.08,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorsTheme.primaryColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month, color: ColorsTheme.black),
                              SizedBox(width: 20),
                              Text(
                                // DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
                                "${dateDay.toUpperCase()}, ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                                style: ThemeTexts.textStyleValueGrey,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),

                SizedBox(height: 10),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter mySetState) {
                      return ReusingWidgets.searchButton(onPress: () async {

                        /// If search don't exist
                        // showAlertDialog(context);

                        if(flightCodeController.text.isEmpty){
                          ReusingWidgets().snackBar(context: context, text: 'Please Enter Flight Code');
                        }

                        else {
                            futureList =  ServicesAirportsTrackScreen().GetAllPosts(flightCodeController.text);
                            modelMyFlightsSearch = ModelSearch(
                              flightCode: flightCodeController.text,
                              arrivalCity: "",
                              departureCity: "",
                              arrivalCityShortName: "",
                              departureCityShortName: "",
                            );

                            setState(() {
                               dataBoxSearch!.add(modelMyFlightsSearch!);
                          });
                        }

                      }, context: context,
                        text: 'SEARCH',
                        style: ThemeTexts.textStyleTitle2,);
                    }
                ),

              ],
            ),
          ),
        ),

        SizedBox(
          height: 0,
          width: w,
          child: FutureBuilder(
            future: futureList,
            builder: (context,snapshot) {
              print("454545");
              if (snapshot.hasData) {
                print("aaaa");
                if (snapshot.data!.response != null) {

                  Future(() async{
                    await Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SearchButtonByFlightCode(
                          flightCode: flightCodeController.text,
                          dateDay: null,
                          currentDate: currentDate,
                        )));
                  });

                  return Container();
                }  else {
                  Future(() {
                    print("14141");
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("No Flights Found"),
                          content: Text("Try again or try searching by flight code.\n\n"
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
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "error 2${snapshot.error}",
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },

          ),
        ),


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
                color: ColorsTheme.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,),),

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
                          currentTask!.flightCode!.isNotEmpty ?
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
                                            mySetState(() {
                                              flightCodeController.text = currentTask.flightCode!;
                                            });
                                          },
                                          child: SizedBox(
                                              width: w * 0.7,
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.history,color: ColorsTheme.primaryColor,),
                                                  SizedBox(width: 10,),
                                                  Text(currentTask.flightCode!,
                                                      style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                                ],
                                              )
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
                          ) : Container();
                      },
                    );
                  }
                },
              ),

              // SearchTabRecentSearches(),

            ],
          ),
        ),

        /// WHITE CONTAINER
      ],
    );
  }


  selectDate(BuildContext context,StateSetter mySetState) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(2022,12,10),
      lastDate: DateTime(2024),
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
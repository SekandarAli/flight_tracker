// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'dart:developer';

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/screen/screen_create_new_trips/myflights_create_new_trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

import '../../../flight_detail/screen/flight_detail_screen.dart';
import '../../model/myflights_upcoming_model.dart';

class MyFlightsOpenCreateNewTrips extends StatefulWidget {
  MyFlightsOpenCreateNewTrips({Key? key,required this.noOfFlights,required this.tripName,required this.currentTask}) : super(key: key);

  int noOfFlights;
  String tripName;
  ModelMyFlightsCreateTrip currentTask;

  @override
  State<MyFlightsOpenCreateNewTrips> createState() => _MyFlightsOpenCreateNewTripsState();
}

class _MyFlightsOpenCreateNewTripsState extends State<MyFlightsOpenCreateNewTrips> {

  TextEditingController? editingController = TextEditingController();
  int? noOfFlights ;
  String? tripName;
  Box<ModelMyFlightsCreateTrip>? taskBox;
  ModelMyFlightsCreateTrip? currentTask;
  @override
  void initState() {
    super.initState();
    noOfFlights = widget.noOfFlights;
    tripName = widget.tripName;
    currentTask = widget.currentTask;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsTheme.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  // height: h * 0.25,
                  width: w,
                  child: Stack(
                    children: [
                      Lottie.asset('assets/lottie/createtripbg.json',),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back,color: ColorsTheme.themeColor,))
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_vert, color: ColorsTheme.themeColor,),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.drive_file_rename_outline),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Rename Trip")
                                    ],
                                  ),
                                ),
                                // PopupMenuItem(
                                //   value: 2,
                                //   child: Row(
                                //     children: [
                                //       Icon(Icons.flight),
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       Text("Add Flight")
                                //     ],
                                //   ),
                                // ),
                                PopupMenuItem(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Delete Trip")
                                    ],
                                  ),
                                ),
                              ],
                              offset: Offset(0, 40),
                              elevation: 2,
                              onSelected: (value) async {
                                if (value == 1)  {

                                  var dialogueText = await ReusingWidgets().dialogueBoxSimple(
                                      context: context,
                                      titleText: "Edit Trip Name",
                                      hintText: "Enter New Trip Name",
                                      textEditingController: editingController!);
                                  if (dialogueText != null) {
                                    setState(() {
                                      currentTask!.tripName = editingController!.text.toString();
                                      tripName = editingController!.text.toString();
                                      currentTask!.save();
                                    });
                                  }
                                  else{
                                    // dialogueText = "Enter Flight Code";
                                  }
                                }
                                else if (value == 2) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFlightCreateNewTrip()));
                                }
                                else if (value == 3) {
                                  deleteDialogue(currentTask: currentTask!);
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.all(15),
                // height: h * 0.1,
                width: w,
                color: ColorsTheme.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tripName!, style: ThemeTexts.textStyleTitle2),
                    SizedBox(height: 5),
                    Text("My Trip", style: ThemeTexts.textStyleTitle3),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.flight),
                        SizedBox(width: 10,),
                        // Text("${widget.noOfFlights} Flights"),
                        Text("Flights"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Builder(


                      builder: (context) {

                        // final items = box.values.toList().cast<ModelMyFlightsCreateTrip>();

                        if (currentTask!.modelMyFlightsUpcoming.isEmpty) {
                          return NoFlightFound();
                        } else {
                          return Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: currentTask!.modelMyFlightsUpcoming.length,
                                    itemBuilder: (context, index) {
                                      // log("qwerty${currentTask!.modelMyFlightsUpcoming[index].toString()}");
                                      return
                                        currentTask!.modelMyFlightsUpcoming[index].flightCode!.isNotEmpty ?
                                        FlightCardScreen().flightCardSimple(
                                            onDismiss: (direction) async {
                                              setState(() {
                                                 log("qwerty${currentTask!.modelMyFlightsUpcoming[index].flightCode.toString()}");
                                                 currentTask!.modelMyFlightsUpcoming.removeWhere((element) => (element.flightCode == currentTask!.modelMyFlightsUpcoming[index].flightCode));
                                                 currentTask!.save();

                                                 // currentTask!.modelMyFlightsUpcoming.removeWhere((element) => (element.flightCode == currentTask!.modelMyFlightsUpcoming[index].flightCode));
                                                 // log("qwerty${currentTask!.modelMyFlightsUpcoming[index]}");
                                                 // var tasks= Hive.box<ModelMyFlightsUpcoming>('modelMyFlightsUpcoming');
                                                 // var task = tasks.values.where((element) => element.flightCode == currentTask!.modelMyFlightsUpcoming[index].flightCode).first;
                                                 // task.();
                                                 // task!.save();
                                                 // taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');
                                                 // print("hel${taskBox!.values.where((element) => element.tripName == currentTask!.tripName).elementAt(0).modelMyFlightsUpcoming.where((element) => (element.flightCode == currentTask!.modelMyFlightsUpcoming[index].flightCode)).elementAt(0).flightCode}");
                                                 //taskBox!.modelMyFlightsUpcoming.;
                                                 //await taskBox!.add(currentTask!);

                                              });
                                            },
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return FlightDetailScreen(
                                                    flight_iata: currentTask!.modelMyFlightsUpcoming[index].flightCode!,);
                                              }));
                                            },
                                            direction: DismissDirection.horizontal,
                                            context: context,
                                            flightCode: currentTask!.modelMyFlightsUpcoming[index].flightCode!,
                                            flightStatus: currentTask!.modelMyFlightsUpcoming[index].flightStatus!,
                                            departureCity: currentTask!.modelMyFlightsUpcoming[index].departureCity!,
                                            departureCityShortCode:currentTask!.modelMyFlightsUpcoming[index].departureCityShortCode!,
                                            departureCityTime: currentTask!.modelMyFlightsUpcoming[index].departureCityTime! ?? "---",
                                            arrivalCity: currentTask!.modelMyFlightsUpcoming[index].arrivalCity!,
                                            arrivalCityShortCode: currentTask!.modelMyFlightsUpcoming[index].arrivalCityShortCode!,
                                            arrivalCityTime: currentTask!.modelMyFlightsUpcoming[index].arrivalCityTime! ?? "---",
                                          )
                                            : Container();
                                    },
                                  ),
                                ),
                              ]
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  Widget flightDetails(
      {required String cityName,
        required String cityShortCode,
        required String cityTime,
        required CrossAxisAlignment crossAlignment}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAlignment,
      children: [
        Text(cityName,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityShortCode,
            style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.black)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
      ],
    );
  }

  Future<String?> deleteDialogue({required var currentTask}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to Delete this Trip?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('CANCEL')),
            TextButton(
                onPressed: () {
                  setState(() {
                    currentTask.delete();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                child: Text('OK')),
          ],
        );
      });

}

// currentTask!.modelMyFlightsUpcoming.removeWhere((element) => (element.flightCode == currentTask!.modelMyFlightsUpcoming[index].flightCode));

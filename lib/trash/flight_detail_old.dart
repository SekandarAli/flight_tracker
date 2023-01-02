// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:developer';

import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/notifications/notification_service.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flight_tracker/flight_detail/model/model_airport_track_screen.dart';
import 'package:flight_tracker/flight_detail/services/services_airports_track_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../myflights/model/my_flight_create_trip_model.dart';


class FlightDetailScreen extends StatefulWidget {
  FlightDetailScreen({super.key,required this.flight_iata,required this.openTrack});

  String flight_iata;
  bool openTrack;

  @override
  State<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends State<FlightDetailScreen> {

  bool trackFlight = true;
  Future<ModelAirportTrackScreen>? futureList;
  String flightCode = "---";
  String departureCityDate = '---';
  String departureCity = "---";
  String departureCityShortCode = "---";
  String departureCityTime = '---';
  String arrivalCity = "---";
  String airlineName = "---";
  String arrivalCityShortCode = "---";
  String airlineShortCode = "---";
  String arrivalCityTime = "---";
  String arrivalCityDate = '---';
  String departureTerminal = "---";
  String arrivalTerminal = "---";
  String departureGate = "---";
  String arrivalGate = "---";
  var duration = "---";
  String baggage = "---";
  String departureAirport = "---";
  String arrivalAirport = "---";
  String flightStatus = "---";
  int? updated;
  String flagCountry = "---";
  LocalNotificationService? service;

  ///   ///   ///   ///   ///
  List<ModelMyFlightsUpcoming> selectedItems = [];
  Box<ModelMyFlightsCreateTrip>? taskBox;
  ModelMyFlightsCreateTrip? task;
  List<ModelMyFlightsUpcoming>? modelItemsList;
  TextEditingController createTripController = TextEditingController();

  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    widget.flight_iata.isNotEmpty ? futureList = ServicesAirportsTrackScreen().GetAllPosts(widget.flight_iata) : null;
    service = LocalNotificationService();
    service!.initialize();
  }

  // ModelMyFlightsUpcoming? modelMyFlightsUpcoming111;
  // Box<ModelMyFlightsUpcoming>? aaa;

  // void addCart(ModelMyFlightsUpcoming cart) {
  //   final cartBox = Hive.box('modelMyFlightsUpcoming');
  //   cartBox.add(cart);
  // }

  @override
  Widget build(BuildContext context) {

    return widget.flight_iata.isEmpty ?
    NoResultFoundScreen()
        :
    Scaffold(
      backgroundColor: ColorsTheme.primaryColor,
      body: SafeArea(
        child: FutureBuilder(
            future: futureList,
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.response != null) {
                  flightCode = snapshot.data!.response!.flightIata ?? "---";
                  departureCity = snapshot.data!.response!.depCity ?? "---";
                  arrivalCity = snapshot.data!.response!.arrCity ?? "---";
                  departureCityShortCode = snapshot.data!.response!.depIata ?? "---";
                  arrivalCityShortCode = snapshot.data!.response!.arrIata ?? "---";
                  departureCityDate = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.response!.depTimeTs! * 1000));
                  departureCityTime = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.response!.depTimeTs! * 1000));
                  arrivalCityDate = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.response!.arrTimeTs! * 1000));
                  arrivalCityTime = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.response!.arrTimeTs! * 1000));
                  departureTerminal = snapshot.data!.response!.depTerminal ?? "---";
                  arrivalTerminal = snapshot.data!.response!.arrTerminal ?? "---";
                  departureGate = snapshot.data!.response!.depGate ?? "---";
                  arrivalGate = snapshot.data!.response!.arrGate ?? "---";
                  updated = snapshot.data!.response!.updated!;
                  duration = snapshot.data!.response!.duration.toString() ?? "---";
                  baggage = snapshot.data!.response!.arrBaggage ?? "---";
                  departureAirport = snapshot.data!.response!.depName ?? "---";
                  arrivalAirport = snapshot.data!.response!.arrName ?? "---";
                  flightStatus = snapshot.data!.response!.status ?? "---";
                  flagCountry = snapshot.data!.response!.flag ?? "---";
                  airlineName = snapshot.data!.response!.airlineName ?? "---";
                  airlineShortCode = snapshot.data!.response!.airlineIcao ?? "---";

                  return SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        CustomMapsButton(
                            flightCode: flightCode,
                            flightStatus: flightStatus.toUpperCase()),
                        SizedBox(height: 20),
                        CustomScrollViewContent()
                      ],
                    ),
                  );
                }
                else {
                  return NoResultFoundScreen();
                }
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "error 2${snapshot.error}",
                  ),
                );
              } else {
                return Center(child: FunctionProgressIndicator());
              }
            }
        ),
      ),
    );
  }

  Widget CustomMapsButton({
    required String flightCode,
    required String flightStatus,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.white,),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: Colors.white,),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Share Flight")
                      ],
                    ),
                  ),
                ],
                offset: Offset(0, 40),
                elevation: 2,
                onSelected: (value) async {
                  if (value == 1)  {
                    Share.share(
                        'Flight Code is $flightCode and its Status is $flightStatus \n Flight is departing from $departureAirport to $arrivalAirport',
                        subject: 'Flight Track Update');
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(flightCode,style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
              Text(flightStatus,style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
        ],
      ),
    );
  }

  Widget CustomScrollViewContent() {
    return Card(
      color: Colors.white,
      elevation: 12.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      margin: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomFlightCountryNameRow(),
            SizedBox(height: 24),
            CustomFlightDetails(
              departureTitle: 'Departure Airport',
              departureSubTitle: departureAirport.length > 17 ? '${departureAirport.substring(0, 17)}...' : departureAirport,
              arrivalTitle: "Arrival Airport",
              arrivalSubTitle: arrivalAirport.length > 17 ? '${arrivalAirport.substring(0, 17)}...' : arrivalAirport,
            ),
            SizedBox(height: 20),
            CustomFlightDetails(
                departureTitle: 'Departure Date',
                departureSubTitle: departureCityDate,
                arrivalTitle: "Arrival Date",
                arrivalSubTitle: arrivalCityDate
            ),
            SizedBox(height: 20),
            CustomFlightDetails(
                departureTitle: 'Departure City',
                departureSubTitle: departureCity,
                arrivalTitle: "Arrival City",
                arrivalSubTitle: arrivalCity
            ),
            SizedBox(height: 15),
            CustomFlightDetails(
                departureTitle: 'Airline Name',
                departureSubTitle: airlineName.length > 17 ? '${airlineName.substring(0, 17)}...' : airlineName,
                arrivalTitle: "Airline Code",
                arrivalSubTitle: airlineShortCode
            ),
            SizedBox(height: 15),
            CustomFlightDetails(
                departureTitle: 'Departure Terminal',
                departureSubTitle: departureTerminal,
                arrivalTitle: "Arrival Terminal",
                arrivalSubTitle: arrivalTerminal
            ),
            SizedBox(height: 15),
            CustomFlightDetails(
                departureTitle: 'Departure Gate',
                departureSubTitle: departureGate,
                arrivalTitle: "Arrival Gate",
                arrivalSubTitle: arrivalGate
            ),
            SizedBox(height: 15),
            CustomFlightDetails(
                departureTitle: 'Duration',
                departureSubTitle: "$duration minutes",
                arrivalTitle: "Airline of Country",
                arrivalSubTitle: flagCountry
            ),

            SizedBox(height: 15),
            CustomBaggageClaim(baggage: baggage),
            SizedBox(height: 24),
            /// bottom two buttons
            widget.openTrack == true ? Container(
                alignment: Alignment.center,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ReusingWidgets.searchButton(
                        onPress: () {
                          setState(() {
                            trackFlight = !trackFlight;

                            if (trackFlight == false) {
                              modelMyFlights = ModelMyFlightsUpcoming(
                                flightCode: flightCode,
                                departureCityDate: departureCityDate,
                                departureCity: departureCityShortCode,
                                departureCityShortCode: departureAirport,
                                departureCityTime: departureCityTime,
                                arrivalCityDate: arrivalCityDate,
                                arrivalCity: arrivalCityShortCode,
                                arrivalCityShortCode: arrivalAirport,
                                arrivalCityTime: arrivalCityTime,
                                flightStatus: flightStatus,
                                flightIata: widget.flight_iata,
                                isSelected: false,
                              );
                              dataBox!.add(modelMyFlights!);
                              /// Notification

                              var date1 = DateTime.now();
                              var date2 = DateTime.fromMillisecondsSinceEpoch(updated! * 1000);
                              print("dates1 $date1");
                              print("dates2 $date2");

                              Duration duration = date1.difference(date2);
                              print("duration$duration");

                              var noOfHours = duration.inHours;
                              print("durationInHours$noOfHours");


                              service!.showScheduleNotification(
                                  id: 0,
                                  title: "Flight Track Update",
                                  body: "Flight Number $flightCode is departing from $departureAirport on $departureCityDate. Status of $flightCode is $flightStatus.",
                                  hours: noOfHours - 1);


                              service!.showScheduleNotification(
                                  id: 1,
                                  title: "Flight Track Update",
                                  body: "Flight Number $flightCode is arriving on $arrivalAirport on $arrivalCityDate. Status of $flightCode is $flightStatus.",
                                  hours: noOfHours);

                              print(modelMyFlights!.arrivalCity);
                            }
                            else {
                              modelMyFlights!.delete();
                              LocalNotificationService().localNotificationService.cancel(0);
                            }
                          });
                        },
                        context: context,
                        text: trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",
                        style: ThemeTexts.textStyleTitle3.copyWith(
                            color: ColorsTheme.white,
                            fontWeight: FontWeight.normal)),

                    ReusingWidgets.searchButton(
                        onPress: () {
                          // openDialogue(
                          //     createTripController: createTripController,
                          //     context: context,
                          //     onTap: ()async {
                          //       var newTask = ModelMyFlightsCreateTrip(
                          //           tripName: createTripController.text.toString(),
                          //           noOfFlights: '',
                          //           tripImage: '',
                          //           isSelected: false,
                          //           modelMyFlightsUpcoming: [
                          //             ModelMyFlightsUpcoming(
                          //             flightCode: flightCode,
                          //             departureCityDate: departureCityDate,
                          //             departureCity: departureCity,
                          //             departureCityShortCode: departureCityShortCode,
                          //             departureCityTime: departureCityTime,
                          //             arrivalCityDate: arrivalCityDate,
                          //             arrivalCity: arrivalCity,
                          //             arrivalCityTime: arrivalCityTime,
                          //             arrivalCityShortCode: arrivalCityShortCode,
                          //             flightStatus: flightStatus,
                          //             flightIata: widget.flight_iata,
                          //             isSelected: false,
                          //           )]
                          //       );
                          //
                          //       taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');
                          //
                          //       await taskBox!.add(newTask);
                          //       Navigator.pop(context);
                          //
                          //       ReusingWidgets().snackBar(context: context, text: "Flight Added Successfully");
                          //
                          //     }
                          // );

                          dialogueAddToTrip(context: context);
                        },
                        context: context,
                        text: "ADD TO TRIPS",
                        style: ThemeTexts.textStyleTitle3.copyWith(
                            color: ColorsTheme.white,
                            fontWeight: FontWeight.normal))
                  ],
                )) : Container()
          ],
        ),
      ),
    );
  }

  Widget CustomFlightCountryName({
    required String cityName,
    required String cityShortCode,
    required String cityTime,
    required CrossAxisAlignment crossAlignment
  }) {
    return Column(
      crossAxisAlignment: crossAlignment,
      children: [
        Text(cityName,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityShortCode,
            style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.black)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.themeColor,fontSize: 20)),
        SizedBox(height: 10),
      ],
    );
  }


  Widget CustomFlightDetails({
    required String departureTitle,
    required String departureSubTitle,
    required String arrivalTitle,
    required String arrivalSubTitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cardRow(title: departureTitle, subTitle: departureSubTitle,crossAxisAlignment: CrossAxisAlignment.start),
          cardRow(title: arrivalTitle, subTitle: arrivalSubTitle,crossAxisAlignment: CrossAxisAlignment.end),
        ],
      ),
    );
  }

  cardRow({
    required String title,
    required String subTitle,
    required CrossAxisAlignment crossAxisAlignment,
  }){
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(title,style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),),
          SizedBox(height: 10,),
          Text(subTitle,style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13),),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Divider(
                thickness: 2,
                color: ColorsTheme.themeColor,
              )),
        ],
      );
  }

  Widget CustomFlightCountryNameRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomFlightCountryName(
                cityName: departureCity,
                cityShortCode: departureCityShortCode,
                crossAlignment: CrossAxisAlignment.start,
                cityTime: departureCityTime),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Image.asset("assets/images/flightIcon.png",
              width:  MediaQuery.of(context).size.width * 0.25,
              height:  MediaQuery.of(context).size.width * 0.25,
            ),
          ),
          Expanded(
            child: CustomFlightCountryName(
                cityName: arrivalCity,
                cityShortCode: arrivalCityShortCode,
                crossAlignment: CrossAxisAlignment.end,
                cityTime: arrivalCityTime),
          ),
        ],
      ),
    );
  }


  Widget CustomBaggageClaim(
      {
        required String baggage,
      }
      ) {
    return Container(
      // height: double.infinity / 2,
      color: ColorsTheme.primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Baggage Claim",
                style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 7),
              color: Colors.white,
              child:  Text(baggage,
                  style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> dialogueAddToTrip({
    required BuildContext context,
  }) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return
                AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical:  MediaQuery.of(context).size.height / 5.5),
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(0),
                  title: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width ,
                      color: ColorsTheme.primaryColor,
                      child: Text("Add To Trip",style: ThemeTexts.textStyleTitle2,)),
                  content: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          createTripController.clear();
                          openDialogue(
                              createTripController: createTripController,
                              context: context,
                              onTap: ()async {
                                var newTask = ModelMyFlightsCreateTrip(
                                    tripName: createTripController.text.toString(),
                                    noOfFlights: '',
                                    tripImage: '',
                                    isSelected: false,
                                    modelMyFlightsUpcoming: [ModelMyFlightsUpcoming(
                                      flightCode: flightCode,
                                      departureCityDate: departureCityDate,
                                      departureCity: departureCity,
                                      departureCityShortCode: departureCityShortCode,
                                      departureCityTime: departureCityTime,
                                      arrivalCityDate: departureCityDate,
                                      arrivalCity: arrivalCity,
                                      arrivalCityTime: arrivalCityTime,
                                      arrivalCityShortCode: arrivalCityShortCode,
                                      flightStatus: flightStatus,
                                      flightIata: widget.flight_iata,
                                      isSelected: false,
                                    )]
                                );

                                taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');

                                await taskBox!.add(newTask);
                                Navigator.pop(context);
                                Navigator.pop(context);

                                ReusingWidgets().snackBar(context: context, text: "Flight Added Successfully");

                              }
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 30,top: 20,bottom: 10),
                          child: Row(
                            children: [
                              Icon(Icons.create_new_folder_outlined),
                              SizedBox(width: 10),
                              Text("Create New Trip",style: ThemeTexts.textStyleTitle2.copyWith(fontWeight: FontWeight.bold,color: ColorsTheme.black),)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(left: 30,top: 5,bottom: 10),
                          child: Row(
                            children: [
                              Icon(Icons.add_box_outlined),
                              SizedBox(width: 10),
                              Text("Add To Existing",style: ThemeTexts.textStyleTitle2.copyWith(fontWeight: FontWeight.bold,color: ColorsTheme.black),)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.3,
                          color: ColorsTheme.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                color: ColorsTheme.white,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: ValueListenableBuilder<Box<ModelMyFlightsCreateTrip>>(
                                  valueListenable: Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip").listenable(),
                                  builder: (context, box, _) {
                                    final items = box.values.toList().cast<ModelMyFlightsCreateTrip>();

                                    if (items.isEmpty) {
                                      return Container();
                                    } else {
                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: box.values.length,
                                        itemBuilder: (context, index) {
                                          ModelMyFlightsCreateTrip? currentTask = box.getAt(index);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                currentTask.isSelected =! currentTask.isSelected!;
                                              });
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  currentTask!.isSelected == true ?
                                                  Icon(Icons.check_box,
                                                    color: ColorsTheme.primaryColor,) :
                                                  Icon(Icons.check_box_outline_blank),
                                                  Text(
                                                    currentTask.tripName,
                                                    style: ThemeTexts.textStyleTitle3
                                                        .copyWith(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).pop();
                        },
                            child: Text('CANCEL')),
                        SizedBox(width: 20),
                        ElevatedButton(onPressed: () async {
                          /// Add to trip

                          modelMyFlights = ModelMyFlightsUpcoming(
                              flightCode: "aaaaa",
                              departureCityDate: "aaaaa",
                              departureCity: "aaaaa",
                              departureCityShortCode: "aaaaa",
                              departureCityTime: "aaaaa",
                              arrivalCityDate: "aaaaa",
                              arrivalCity: "aaaaa",
                              arrivalCityShortCode: "aaaaa",
                              arrivalCityTime: "aaaaa",
                              flightStatus: "aaaaa",
                              flightIata: "aaaaa",
                              isSelected: false,
                              departureLat: "aaaaaaa",
                              arrivalLat: "aaaaaaa"
                          );

                          task = ModelMyFlightsCreateTrip(
                              tripName: "",
                              noOfFlights: '',
                              tripImage: '',
                              isSelected: false,
                              modelMyFlightsUpcoming: modelMyFlights
                          );
                          //
                          //  taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');
                          //
                          //  if (task != null) {
                          //    task!.tripName = newTask.tripName;
                          //    modelItemsList = selectedItems;
                          //    task!.save();
                          //    Navigator.pop(context);
                          //  }
                          //
                          //  else {
                          //    await taskBox!.add(newTask);
                          //    Navigator.pop(context);
                          //  }

                          ///




                          // addCart(modelMyFlights!);

                          // dataBox!.putAt(0,modelMyFlights!);


                          // dataBox!.add(modelMyFlights!);

                          // taskBox!.put(modelMyFlights!.key, task!);
                          // taskBox!.putAt(0,task!);
                          // taskBox?.addAll(modelMyFlights!.key);
                          // aaa!.add(abc!);

                          // taskBox!.add(abc);



                          // taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');
                          // taskBox.add(value)


                          // taskBox!.deleteAll(taskBox!.keys); //delete all trips
                          taskBox!.deleteAt(0); //delete from specific index



                          Navigator.pop(context);
                          log("ADD");
                        },
                            child: Text('ADD')),
                      ],
                    ),
                  ],
                );
            }
        );
      });

  Future<String?> openDialogue({
    required TextEditingController createTripController,
    required BuildContext context,
    required Function() onTap,
  }) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trip Name'),
          content: textFormFields(
              width: MediaQuery.of(context).size.width / 2,
              hintText: "Enter Trip Name",
              textController: createTripController),
          actions: [
            TextButton(
                onPressed: (){
                  onTap();
                },
                child: Text('OK')),
            TextButton(
                onPressed: () async{
                  Navigator.of(context).pop();
                },
                child: Text('CANCEL')),
          ],
        );
      });

  Widget textFormFields({
    required double width,
    required String hintText,
    required TextEditingController textController,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: textController,
        style: TextStyle(fontSize: 12),
        // keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

}
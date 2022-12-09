// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/notifications/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flight_tracker/flight_detail/model/model_airport_track_screen.dart';
import 'package:flight_tracker/flight_detail/services/services_airports_track_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/maps/custom_google_maps.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../myflights/model/my_flight_create_trip_model.dart';


class FlightDetailScreen extends StatefulWidget {
  FlightDetailScreen({super.key, this.flight_iata});
  String? flight_iata;

  @override
  State<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends State<FlightDetailScreen> {

  bool trackFlight = true;
  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  Future<ModelAirportTrackScreen>? futureList;

  String flightCode = "---";
  String departureCityDate = '---';
  String departureCity = "---";
  String departureCityShortCode = "---";
  String departureCityTime = '---';
  String arrivalCity = "---";
  String arrivalCityShortCode = "---";
  String arrivalCityTime = "---";
  String arrivalCityDate = '---';
  String departureLat = "24.8607";
  String departureLng = "67.0011";
  String arrivalLat = "31.5204";
  String arrivalLng = "74.3587";
  String departureTerminal = "---";
  String arrivalTerminal = "---";
  String departureGate = "---";
  String arrivalGate = "---";
  String duration = "---";
  String flightTimeLeft = "---";
  String baggage = "---";
  String departureAirport = "---";
  String arrivalAirport = "---";
  String flightStatus = "---";
  int? updated;
  var distance = "---";

  LocalNotificationService? service;

  ///   ///   ///   ///   ///
  List<ModelMyFlightsUpcoming> selectedItems = [];
  Box<ModelMyFlightsCreateTrip>? taskBox;
  ModelMyFlightsCreateTrip? task;
  List<ModelMyFlightsUpcoming>? modelItemsList;




  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    widget.flight_iata != null ? futureList = ServicesAirportsTrackScreen().GetAllPosts(widget.flight_iata!) : null;
    // widget.flight_iata = "IX142";
    // futureList = ServicesAirportsTrackScreen().GetAllPosts(widget.flight_iata!);
    service = LocalNotificationService();
    service!.initialize();
  }

  @override
  Widget build(BuildContext context) {

    return widget.flight_iata == null ?
    Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.no_backpack_outlined,size: 50,),
              Text("Oops! No Data Found"),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("BACK"))
            ],
          ),
        ))
        :
    Scaffold(
      bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text(
                    trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",
                    style: ThemeTexts.textStyleTitle3.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    trackFlight = !trackFlight;

                    if (trackFlight == false) {
                      modelMyFlights = ModelMyFlightsUpcoming(
                        flightCode: flightCode,
                        departureCityDate: departureCityDate,
                        departureCity: departureCity,
                        departureCityShortCode: departureCityShortCode,
                        departureCityTime: departureLat,
                        arrivalCityDate: departureCityDate,
                        arrivalCity: arrivalCity,
                        arrivalCityShortCode: arrivalCityShortCode,
                        arrivalCityTime: departureLng,
                        departureLat: departureLat,
                        departureLng: departureLng,
                        arrivalLat: arrivalLat,
                        arrivalLng: arrivalLng,
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
                      print("duration${duration}");

                      var noOfHours = duration.inHours;

                      service!.showScheduleNotification(
                          id: 0,
                          title: "Flight Track Update",
                          body: "Flight Number $flightCode is departing from $departureAirport on $departureCityDate. Status of $flightCode is $flightStatus.",
                          hours: noOfHours - 1);


                      service!.showScheduleNotification(
                          id: 1,
                          title: "Flight Track Update",
                          body: "Flight Number $flightCode is arriving on $arrivalAirport on $arrivalCityDate. Status of $flightCode is $flightStatus.",
                          hours: noOfHours - 1);

                      print(modelMyFlights!.arrivalCity);
                    }
                    else {
                      modelMyFlights!.delete();
                      LocalNotificationService().localNotificationService.cancel(0);
                    }
                  });
                },
              ),
              TextButton(
                child: Text("ADD TO TRIPS",
                    style: ThemeTexts.textStyleTitle3.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.normal)),
                onPressed: () {

                  dialogueAddToTrip(
                    context: context,
                  );
                },
              ),
            ],
          )),
      body: FutureBuilder(
          future: futureList,
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.response != null) {
                flightCode = snapshot.data!.response!.flightIata ?? "---";
                departureCity = snapshot.data!.response!.depCity ?? "---";
                arrivalCity = snapshot.data!.response!.arrCity ?? "---";
                departureCityShortCode = snapshot.data!.response!.depCountry ?? "---";
                arrivalCityShortCode = snapshot.data!.response!.arrCountry ?? "---";
                departureCityDate = snapshot.data!.response!.depTime ?? "---";
                arrivalCityDate = snapshot.data!.response!.arrTime ?? "---";
                departureTerminal = snapshot.data!.response!.depTerminal ?? "---";
                arrivalTerminal = snapshot.data!.response!.arrTerminal ?? "---";
                departureGate = snapshot.data!.response!.depGate ?? "---";
                arrivalGate = snapshot.data!.response!.arrGate ?? "---";
                updated = snapshot.data!.response!.updated!;
                distance = DateTime.fromMillisecondsSinceEpoch(updated! * 1000).toString();
                duration = snapshot.data!.response!.duration.toString() ?? "---";
                flightTimeLeft = snapshot.data!.response!.flag ?? "---";
                baggage = snapshot.data!.response!.arrBaggage ?? "---";
                departureAirport = snapshot.data!.response!.depName ?? "---";
                arrivalAirport = snapshot.data!.response!.arrName ?? "---";
                flightStatus = snapshot.data!.response!.status ?? "---";

                return Stack(
                  children: [
                    CustomGoogleMaps(
                      departureLng: double.parse(departureLng),
                      departureLat: double.parse(departureLat),
                      arrivalLat: double.parse(arrivalLat),
                      arrivalLng: double.parse(arrivalLng),
                    ),
                    CustomMapsButton(),
                    DraggableScrollableSheet(
                      initialChildSize: 0.45,
                      minChildSize: 0.15,
                      snap: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: CustomScrollViewContent(),
                        );
                      },
                    ),
                  ],
                );
              }
              else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.no_backpack_outlined,size: 50,),
                      Text("Oops! No Data Found"),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("BACK"))
                    ],
                  ),
                );
                // return Center(
                //   child: Text(
                //     "error 1${snapshot.error}",
                //   ),
                // );
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
    );
  }

  Widget CustomMapsButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black,),
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
              // else if (value == 2) {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFlightCreateNewTrip()));
              // }
            },
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
            SizedBox(height: 12),
            CustomDraggingHandle(),
            SizedBox(height: 10),
            CustomFlightName(),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 16),
            CustomFlightCountryNameRow(),
            SizedBox(height: 24),
            CustomTerminalGate(),
            SizedBox(height: 24),
            CustomDistanceDurationRow(),
            SizedBox(height: 24),
            CustomBaggageClaim(baggage: baggage),
            SizedBox(height: 24),
            CustomSeatAircraftInfo(context: context),
            SizedBox(height: 20),
            CustomAirportDetails(context: context,airportName: departureAirport,depOrArr: "Departure Airport",time: departureCityDate),
            SizedBox(height: 20),
            CustomAirportDetails(context: context,airportName: arrivalAirport,depOrArr: "Arrival Airport",time: arrivalCityDate)
          ],
        ),
      ),
    );
  }

  Widget CustomDraggingHandle() {
    return Container(
      height: 5,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget CustomFlightName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          color: ColorsTheme.primaryColor,
          child: Text(flightCode,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
        ),
        Text(flightStatus,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
      ],
    );
  }

  Widget CustomFlightCountryName({
    required String cityName,
    required String cityShortCode,
    required String cityTime,
    required String cityDate,
    required CrossAxisAlignment crossAlignment
  }) {
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
        Text("🗓️ $cityDate",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey,fontSize: 8)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget CustomFlightCountryNameRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomFlightCountryName(
              cityName: departureCity,
              cityShortCode: departureCityShortCode,
              cityTime: departureLat,
              cityDate: departureCityDate,
              crossAlignment: CrossAxisAlignment.start),
          RotatedBox(quarterTurns: 1,
              child: Icon(Icons.flight, size: 40,color: Colors.grey,)),
          CustomFlightCountryName(
              cityName: arrivalCity,
              cityShortCode: arrivalCityShortCode,
              cityTime: departureLng,
              cityDate: arrivalCityDate,
              crossAlignment: CrossAxisAlignment.end),
        ],
      ),
    );
  }

  Widget CustomTerminalGate() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomTerminalGateRow(text: "Terminal",container: departureTerminal ),
              SizedBox(width: 10),
              CustomTerminalGateRow(text: "Gate",container: departureGate ),
            ],
          ),
          Row(
            children: [
              CustomTerminalGateRow(text: "Terminal",container: arrivalTerminal ),
              SizedBox(width: 10),
              CustomTerminalGateRow(text: "Gate",container: arrivalGate ),
            ],
          ),

        ],
      ),
    );
  }

  Widget CustomTerminalGateRow({
    required String text,
    required String container,
  }) {
    return Column(
      children: [
        Text(text,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 7),
          color: Colors.grey,
          child:  Text(container,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
        )
      ],
    );
  }


  Widget CustomDistanceDuration({
    required String text,
    required String detail,
  }) {
    return Column(
      children: [
        Text(text,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(detail,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black)),
      ],
    );
  }

  Widget CustomDistanceDurationRow() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDistanceDuration(text: "DateTime",detail: distance.substring(0,19)),
          CustomDistanceDuration(text: "Duration",detail: duration),
          CustomDistanceDuration(text: "Flag",detail: flightTimeLeft),
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

  Widget CustomSeatAircraftInfo({required BuildContext context}) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child:
              Image.asset("assets/images/airline.png", fit: BoxFit.cover)),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Seat Map",
                        style: ThemeTexts.textStyleTitle2.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    Text("Airplane",
                        style: ThemeTexts.textStyleTitle3
                            .copyWith(color: Colors.black)),
                    SizedBox(height: 5),
                  ],
                ),
                TextButton(
                  child: Text("Info",
                      style: ThemeTexts.textStyleTitle2.copyWith(
                          color: ColorsTheme.primaryColor,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CustomAirportDetails({
    required BuildContext context,
    required String airportName,
    required String depOrArr,
    required String time,
  }) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.25,
            width: w,
            child: Image.asset('assets/images/airport.jpg', fit: BoxFit.fill),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: w,
            color: ColorsTheme.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(airportName,
                    style: ThemeTexts.textStyleTitle2
                        .copyWith(color: Colors.black)),
                SizedBox(height: 5),
              ],
            ),
          ),
          Container(
            width: w,
            color: ColorsTheme.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(depOrArr,
                              style: ThemeTexts.textStyleTitle2
                                  .copyWith(color: Colors.grey)),
                          Text("Local Time: $time",
                              style: ThemeTexts.textStyleTitle3
                                  .copyWith(color: Colors.grey)),
                        ],
                      ),
                      Text("86°C",
                          style: ThemeTexts.textStyleTitle1
                              .copyWith(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    container(icon: Icons.info, text: "INFO"),
                    container(icon: Icons.assistant_navigation, text: "NAV"),
                    container(
                        icon: Icons.sports_baseball_rounded, text: "WEBSITE"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget container({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.all(5),
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

  Future<String?> dialogueAddToTrip({
    required BuildContext context,
  }) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return
            AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 200),
              title: Text("Add To Trip"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: ColorsTheme.white,
                    width: 200,
                    child: ValueListenableBuilder<
                        Box<ModelMyFlightsCreateTrip>>(
                      valueListenable:
                      Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip")
                          .listenable(),
                      builder: (context, box, _) {
                        final items = box.values.toList().cast<ModelMyFlightsCreateTrip>();

                        if (items.isEmpty) {
                          return Center(child: Text("No Trip Found!"));
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              ModelMyFlightsCreateTrip? currentTask = box.getAt(index);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentTask.isSelected = !currentTask.isSelected!;
                                    if (currentTask.isSelected == true) {
                                      modelMyFlights = ModelMyFlightsUpcoming(
                                        flightCode: flightCode,
                                        departureCityDate: departureCityDate,
                                        departureCity: departureCity,
                                        departureCityShortCode: departureCityShortCode,
                                        departureCityTime: departureLat,
                                        arrivalCityDate: departureCityDate,
                                        arrivalCity: arrivalCity,
                                        arrivalCityShortCode: arrivalCityShortCode,
                                        arrivalCityTime: departureLng,
                                        departureLat: departureLat,
                                        departureLng: departureLng,
                                        arrivalLat: arrivalLat,
                                        arrivalLng: arrivalLng,
                                        flightStatus: flightStatus,
                                        flightIata: widget.flight_iata,
                                        isSelected: false,
                                      );
                                      print("true");
                                      print(currentTask.isSelected);
                                    }
                                    else if (currentTask.isSelected == false) {
                                      print("faalse");
                                      print(currentTask.isSelected);
                                    }
                                    else {
                                      print("aaaaaaaaaaa");
                                    }
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
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                        child: Text('CANCEL')),
                    TextButton(onPressed: () async {
                      // var newTask = ModelMyFlightsCreateTrip(
                      //     tripName: "",
                      //     noOfFlights: '',
                      //     tripImage: '',
                      //     isSelected: false,
                      //     modelMyFlightsUpcoming: modelMyFlights
                      // );
                      //
                      // taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');
                      //
                      // if (task != null) {
                      //   task!.tripName = newTask.tripName;
                      //   modelItemsList = selectedItems;
                      //   task!.save();
                      //   Navigator.pop(context);
                      // }
                      //
                      // else {
                      //   await taskBox!.add(newTask);
                      //   Navigator.pop(context);
                      // }
                        Navigator.pop(context);
                    },
                        child: Text('ADD')),
                  ],
                ),
              ],
            );
          }
        );
      });

}
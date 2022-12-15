// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/notifications/notification_service.dart';
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
  String arrivalLat = "31.5204";
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

  TextEditingController createTripController = TextEditingController();


  var modelMyFlightsNew;


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
    NoResultFoundScreen()
        :
    Scaffold(
      bottomNavigationBar: Container(
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
                          departureCity: departureCity,
                          departureCityShortCode: departureCityShortCode,
                          departureCityTime: departureLat,
                          arrivalCityDate: departureCityDate,
                          arrivalCity: arrivalCity,
                          arrivalCityShortCode: arrivalCityShortCode,
                          arrivalCityTime: arrivalLat,
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
                        print("durationInHours${noOfHours}");


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
                    dialogueAddToTrip(
                        context: context
                    );
                  },
                  context: context,
                  text: "ADD TO TRIPS",
                  style: ThemeTexts.textStyleTitle3.copyWith(
                      color: ColorsTheme.white,
                      fontWeight: FontWeight.normal))
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
                    Container(
                      color: ColorsTheme.primaryColor,
                    ),
                    CustomMapsButton(
                        flightCode: flightCode,
                        flightStatus: flightStatus),
                    DraggableScrollableSheet(
                      initialChildSize: 0.75,
                      minChildSize: 0.7,
                      snap: true,
                      expand: true,
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
    );
  }

  Widget CustomMapsButton({
  required String flightCode,
  required String flightStatus,
}) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
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
                  // else if (value == 2) {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFlightCreateNewTrip()));
                  // }
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
                departureSubTitle: departureAirport.substring(0,20),
                arrivalTitle: "Arrival Airport",
                arrivalSubTitle: arrivalAirport.substring(0,20)
            ),
            SizedBox(height: 20),
            CustomFlightDetails(
                departureTitle: 'Departure Time',
                departureSubTitle: departureCityDate,
                arrivalTitle: "Arrival Time",
                arrivalSubTitle: arrivalCityDate
            ),
            SizedBox(height: 20),

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
            CustomBaggageClaim(baggage: baggage),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget CustomFlightCountryName({
    required String cityName,
    required String cityShortCode,
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
                crossAlignment: CrossAxisAlignment.start),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Image.asset("assets/images/flightIcon.png",
              width:  MediaQuery.of(context).size.width * 0.3,
              height:  MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          Expanded(
            child: CustomFlightCountryName(
                cityName: arrivalCity,
                cityShortCode: arrivalCityShortCode,
                crossAlignment: CrossAxisAlignment.end),
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
              insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical:  MediaQuery.of(context).size.height / 4),
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              title: Container(
                  padding: EdgeInsets.all(10),
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
                                  departureCityTime: departureLat,
                                  arrivalCityDate: departureCityDate,
                                  arrivalCity: arrivalCity,
                                  arrivalCityTime: arrivalLat,
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    color: ColorsTheme.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: ColorsTheme.white,
                          width: MediaQuery.of(context).size.width * 0.75,
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
                                          // if (currentTask.isSelected == true) {
                                          //   var newTask = ModelMyFlightsCreateTrip(
                                          //       tripName: currentTask.tripName.toString(),
                                          //       noOfFlights: '',
                                          //       tripImage: '',
                                          //       isSelected: false,
                                          //       modelMyFlightsUpcoming: modelMyFlightsNew = [ModelMyFlightsUpcoming(
                                          //         flightCode: flightCode,
                                          //         departureCityDate: departureCityDate,
                                          //         departureCity: departureCity,
                                          //         departureCityShortCode: departureCityShortCode,
                                          //         departureCityTime: departureLat,
                                          //         arrivalCityDate: departureCityDate,
                                          //         arrivalCity: arrivalCity,
                                          //         arrivalCityTime: arrivalLat,
                                          //         arrivalCityShortCode: arrivalCityShortCode,
                                          //         flightStatus: flightStatus,
                                          //         flightIata: widget.flight_iata,
                                          //         isSelected: false,
                                          //       )]
                                          //   );
                                          //
                                          //   taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');
                                          //
                                          //   await taskBox!.add(newTask);
                                          //
                                          // ReusingWidgets().snackBar(context: context, text: "Flight Added Successfully");
                                          // }
                                          // else if (currentTask.isSelected == false) {
                                          //   print("faalse");
                                          //   print(currentTask.isSelected);
                                          //   modelMyFlightsNew.delete();
                                          // }
                                          // else {
                                          //   print("aaaaaaaaaaa");
                                          // }
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

  Future<String?> openDialogue({
    required TextEditingController createTripController,
    required BuildContext context,
    required Function() onTap,
  }) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Trip'),
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
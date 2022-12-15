// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
import 'package:flight_tracker/flight_detail/screen/flight_detail_screen.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/myflights/screen/screen_create_new_trips/myflights_create_new_trip_screen.dart';
import 'package:flight_tracker/myflights/screen/screen_create_new_trips/myflights_open_create_new_trips.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import '../../functions/function_progress_indicator.dart';
import 'screen_view_all_flights/myflights_view_all.dart';

class MyFlightsScreen extends StatefulWidget {
  const MyFlightsScreen({Key? key}) : super(key: key);

  @override
  State<MyFlightsScreen> createState() => _MyFlightsScreenState();
}

class _MyFlightsScreenState extends State<MyFlightsScreen> {
  TextEditingController createTripController = TextEditingController();
  ModelMyFlightsCreateTrip? task;
  List<ModelMyFlightsUpcoming>? modelItemsList;

  bool viewAllTrips = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsTheme.primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return  FlightDetailScreen(flight_iata: "IX142", openTrack: true);
                  }));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              Text("My Flights",
                                style: ThemeTexts.textStyleTitle2.copyWith(letterSpacing: 2),
                              ),
                          Text(DateTime.now().toString().substring(0,10),
                            style: ThemeTexts.textStyleTitle2.copyWith(letterSpacing: 2,fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                ),
              ),

              /// CREATE NEW TRIP STARTS

              Container(
                padding: EdgeInsets.only(top: 30),
                decoration: ReusingWidgets().curveDecorationContainer(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        createTrip(
                            width: w,
                            onTap: () {
                              createTripController.clear();
                              openDialogue(
                                createTripController: createTripController,
                                context: context,
                                onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return MyFlightCreateNewTrip(tripName: createTripController.text.toString());
                                    }));
                                }
                              );
                            }),
                        Container(
                          color: ColorsTheme.white,
                          height: w * 0.4,
                          width: w * 0.62,
                          child: ValueListenableBuilder<Box<ModelMyFlightsCreateTrip>>(
                            valueListenable:
                            Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip").listenable(),
                            builder: (context, box, _) {
                              final items = box.values.toList().cast<ModelMyFlightsCreateTrip>();

                              if (items.isEmpty) {
                                return Container();
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: box.values.length,
                                  itemBuilder: (context, index) {
                                    ModelMyFlightsCreateTrip? currentTask = box.getAt(index);
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            print(currentTask.tripName);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return MyFlightsOpenCreateNewTrips(
                                                noOfFlights: currentTask.modelMyFlightsUpcoming.length,
                                                tripName: currentTask.tripName,
                                                currentTask: currentTask,
                                              );
                                            }));
                                          },
                                          child: SizedBox(
                                            height: w * 0.4,
                                            width: w * 0.32,
                                            child: Card(
                                              color: ColorsTheme.lightThemeColor,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Lottie.asset(
                                                    'assets/lottie/lottietrip.json',
                                                    width: w * 0.4,
                                                    height: w * 0.3,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    currentTask!.tripName,
                                                    style: ThemeTexts.textStyleTitle3.copyWith(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1),
                                                  ),
                                                  // SizedBox(height: 5),
                                                  // Text(
                                                  //   "${currentTask.modelMyFlightsUpcoming!.length} Flights",
                                                  //   style: ThemeTexts.textStyleTitle3.copyWith(
                                                  //       color: Colors.white,
                                                  //       letterSpacing: 0),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        Spacer(),

                      ],
                    ),
                    /// CREATE NEW TRIP END

                    /// My Upcoming Flights Starts

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // myUpComingFlightsText(text: "My Upcoming Flights", icon: Icons.flight_outlined),
                        viewAllTrips == false
                            ?
                        myUpComingFlightsText(text: "View All Trips",color: ColorsTheme.primaryColor,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return MyFlightsViewAll();
                            }));
                          },) :
                        myUpComingFlightsText(text: "",color: ColorsTheme.primaryColor,
                          onTap: () {},)
                      ],
                    ),

                    SizedBox(
                      height: h * 0.7,
                      width: w,
                      child: ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
                        valueListenable:
                        Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming").listenable(),
                        builder: (context, box, _) {
                          final items = box.values.toList().cast<ModelMyFlightsUpcoming>();


                          if (items.isEmpty) {
                            viewAllTrips = false;
                            return NoFlightFound();
                          } else {
                            viewAllTrips = true;
                            return Flex(
                                direction: Axis.vertical,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: box.values.length,
                                      itemBuilder: (context, index) {
                                        ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                                        return FlightCardScreen().flightCardSimple(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return FlightDetailScreen(flight_iata: currentTask.flightIata!,openTrack: false,);
                                            }));
                                          },
                                          onDismiss: (direction){
                                            setState(() {
                                              currentTask.delete();
                                            });
                                          },
                                          direction: DismissDirection.horizontal,
                                          context: context,
                                            flightCode: currentTask!.flightCode!,
                                            flightStatus: currentTask.flightStatus!,
                                            departureCity: currentTask.departureCity!,
                                            departureCityShortCode: currentTask.departureCityShortCode!,
                                            departureCityTime: currentTask.departureCityTime!,
                                            arrivalCity: currentTask.arrivalCity!,
                                            arrivalCityShortCode: currentTask.arrivalCityShortCode!,
                                            arrivalCityTime: currentTask.arrivalCityTime!,
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

            ],
          ),
        ),
      ),
    );
  }

  Widget myUpComingFlightsText({
    required String text,
    IconData? icon,
    Function()? onTap,
    Color? color
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){onTap!();},
        child: Row(
          children: [
            Icon(icon),
            Text(
              text,
              style: ThemeTexts.textStyleValueBlack.copyWith(letterSpacing: 1,color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTrip({required double width, required Function() onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: ColorsTheme.white,
        margin: EdgeInsets.all(4),
        height: width * 0.4,
        width: width * 0.32,
        child: Card(
          color: ColorsTheme.lightPrimaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.add_circle_outlined,
              //   color: ColorsTheme.primaryColor,
              //   size: width * 0.12,
              // ),
              // SizedBox(height: 10),
              Text(
                "Create\nNew",
                style: ThemeTexts.textStyleTitle2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              )
            ],
          ),
        ),
      ),
    );
  }

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

  Widget flightDetails(
      {required String cityName,
        required String cityShortCode,
        required String cityTime,
        required CrossAxisAlignment crossAlignment}) {
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
            style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.themeColor)),
        SizedBox(height: 10),
      ],
    );
  }

}
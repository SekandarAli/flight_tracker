// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/myflights_model.dart';
import 'package:flight_tracker/myflights/screen/myflights_create_new_trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightsScreen extends StatefulWidget {
  const MyFlightsScreen({Key? key}) : super(key: key);

  @override
  State<MyFlightsScreen> createState() => _MyFlightsScreenState();
}

class _MyFlightsScreenState extends State<MyFlightsScreen> {
  TextEditingController createTripController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsTheme.myFlightsbg,
      appBar: AppBar(
        title: Text(
          "MY FLIGHTS",
          style: ThemeTexts.textStyleTitle2
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              myUpComingFlightsText(text: "My Trips", icon: Icons.kitchen),
              Row(
                children: [
                  createTrip(
                      width: w,
                      onTap: () {
                        openDialogue();
                      }),
                ],
              ),
              /// My Upcoming Flights
              ///
              myUpComingFlightsText(
                  text: "My Upcoming Flights", icon: Icons.flight_outlined),

              SizedBox(
                height: h * 0.7,
                width: w,
                child: ValueListenableBuilder<Box<ModelMyFlights>>(
                  valueListenable:
                      Hive.box<ModelMyFlights>("modelMyFlights").listenable(),
                  builder: (context, box, _) {
                    final items = box.values.toList().cast<ModelMyFlights>();

                    if (items.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.flight,
                                size: w * 0.4,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "No Flights Found",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: w * 0.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                          child: ListView.builder(
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              ModelMyFlights? currentTask = box.getAt(index);
                              return Dismissible(
                                key: Key(UniqueKey().toString()),
                                background: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(15),
                                  color: Colors.red,
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.delete,color: Colors.white,),
                                    Icon(Icons.delete,color: Colors.white,),
                                  ],
                                    ),
                                      ),
                                onDismissed: (direction){
                                  setState(() {
                                    currentTask.delete();
                                  });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Flight Removed Successfully'),duration: Duration(milliseconds: 700)));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        color: ColorsTheme.primaryColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(currentTask!.flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
                                            Text("Scheduled", style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(15),
                                        color: Colors.grey.shade100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("🗓️ ${currentTask.departureCityDate}",
                                                style: ThemeTexts.textStyleTitle3
                                                    .copyWith(
                                                        color: Colors.black87)),
                                            Text("🗓️ ${currentTask.arrivalCityDate}",
                                                style: ThemeTexts.textStyleTitle3
                                                    .copyWith(
                                                        color: Colors.black87)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            flightDetails(
                                                cityName: currentTask.departureCity,
                                                cityShortCode: currentTask.departureCityShortCode,
                                                cityTime: currentTask.departureCityTime,
                                                crossAlignment:
                                                    CrossAxisAlignment.start),
                                            Icon(Icons.flight_land_rounded,
                                                size: 50),
                                            flightDetails(
                                                cityName: currentTask.arrivalCity,
                                                cityShortCode: currentTask.arrivalCityShortCode,
                                                cityTime: currentTask.arrivalCityTime,
                                                crossAlignment:
                                                    CrossAxisAlignment.end),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
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
      ),
      // body:
    );
  }

  Widget myUpComingFlightsText({
    required String text,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          Text(
            text,
            style: ThemeTexts.textStyleValueBlack.copyWith(letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  Widget createTrip({required double width, required Function() onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(4),
        height: width * 0.37,
        width: width * 0.37,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outlined,
                color: ColorsTheme.primaryColor,
                size: width * 0.12,
              ),
              SizedBox(height: 10),
              Text(
                "Create New Trip",
                style: ThemeTexts.textStyleTitle3.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Trip'),
          content: textFormFields(
              width: MediaQuery.of(context).size.width / 2,
              hintText: "Enter Name",
              textController: createTripController),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddMyFlightsScreen();
                  }));
                },
                child: Text('OK')),
            TextButton(
                onPressed: () {
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
}

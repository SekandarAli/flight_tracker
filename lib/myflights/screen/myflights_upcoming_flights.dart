// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightsUpcomingScreen extends StatefulWidget {
  const MyFlightsUpcomingScreen({Key? key}) : super(key: key);

  @override
  State<MyFlightsUpcomingScreen> createState() => _MyFlightsUpcomingScreenState();
}

class _MyFlightsUpcomingScreenState extends State<MyFlightsUpcomingScreen> {

  Box<ModelMyFlightsCreateTrip>? dataBox;
  ModelMyFlightsCreateTrip? modelMyFlights;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
  }
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        title: Text("MY FLIGHTS", style: ThemeTexts.textStyleTitle2
            .copyWith(fontWeight: FontWeight.normal)),
        actions: [
          TextButton(onPressed: (){}, child: Text("EDIT",style: ThemeTexts.textStyleTitle3,))
        ],
      ),
      body:ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
        valueListenable:
        Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming").listenable(),
        builder: (context, box, _) {
          final items = box.values.toList().cast<ModelMyFlightsUpcoming>();

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
            return  ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
              valueListenable:
              Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming").listenable(),
              builder: (context, box, _) {
                final items = box.values.toList().cast<ModelMyFlightsUpcoming>();

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
                              ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                              return Dismissible(
                                key: Key(
                                    UniqueKey().toString()),
                                background: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(15),
                                  color: Colors.red.shade800,
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

                                            Icon(Icons.flight_land_rounded, size: 50),

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
            );
          }
        },
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

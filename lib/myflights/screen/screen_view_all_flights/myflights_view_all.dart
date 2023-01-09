// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
import 'package:flight_tracker/flight_detail/screen/flight_detail_screen.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightsViewAll extends StatefulWidget {
  const MyFlightsViewAll({Key? key}) : super(key: key);

  @override
  State<MyFlightsViewAll> createState() => _MyFlightsViewAllState();
}

class _MyFlightsViewAllState extends State<MyFlightsViewAll> {
  TextEditingController createTripController = TextEditingController();
  ModelMyFlightsCreateTrip? task;
  List<ModelMyFlightsUpcoming>? modelItemsList;

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        icon: Icon(Icons.arrow_back,color: Colors.white,)),
                    Text("All Track Trips",
                      style: ThemeTexts.textStyleTitle2.copyWith(letterSpacing: 2),
                    ),

                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 30),
                decoration: ReusingWidgets().curveDecorationContainer(),
                child: ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
                  valueListenable:
                  Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming").listenable(),
                  builder: (context, box, _) {
                    final items = box.values.toList().cast<ModelMyFlightsUpcoming>();


                    if (items.isEmpty) {
                      return NoFlightFound();
                    } else {
                      return ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                          return FlightCardScreen().flightCardSimple(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return FlightDetailScreen(flight_iata: currentTask.flightIata!,);
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
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/airlines/screen/airline_track_flight.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import '../../airports/model/model_airport_dep_arr.dart';
import '../../airports/services/services_airport_departure.dart';
import '../../functions/function_progress_indicator.dart';

class AirlineScreenDetails extends StatefulWidget {
   AirlineScreenDetails({required this.airlineName,required this.iataValue});

   String airlineName;
   String iataValue;

  @override
  State<AirlineScreenDetails> createState() => _AirlineScreenDetailsState();
}

class _AirlineScreenDetailsState extends State<AirlineScreenDetails> {

  Future<ModelAirportDepArr>? futureListDeparture;

  @override
  void initState() {
    super.initState();
    futureListDeparture = ServicesAirportsDeparture().GetAllPosts(widget.iataValue);

  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: h * 0.25,
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/airline.png'),
                      fit: BoxFit.fill),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,))
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                // height: h * 0.1,
                width: w,
                color: ColorsTheme.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.airlineName, style: ThemeTexts.textStyleTitle2),
                    SizedBox(height: 5),
                    Text("Airline", style: ThemeTexts.textStyleTitle3),
                  ],
                ),
              ),
              Container(
                // height: h * 0.2,
                width: w,
                color: ColorsTheme.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        container(icon: Icons.info, text: "INFO"),
                        container(
                            icon: Icons.sports_baseball_rounded,
                            text: "WEBSITE"),
                      ],
                    ),
                    Container(
                      color: ColorsTheme.primaryColor,
                      height: 15,
                    ),
                  ],
                ),
              ),
              Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("TIME"),
                              Text("DEP/ARR"),
                              Text("NR/STATE"),
                            ],
                          ),
                        ),
                        // Container(
                        //   height: h * 0.7,
                        //   child: FutureBuilder(
                        //     future: futureListDeparture,
                        //     builder: (context,snapshot) {
                        //       if (snapshot.hasData) {
                        //         if (snapshot.data!.response!.isNotEmpty) {
                        //           return Container(
                        //             color: Colors.white,
                        //             child: Column(
                        //               children: [
                        //                 Flexible(
                        //                   child: ListView.builder(
                        //                     padding: EdgeInsets.all(5),
                        //                     itemCount: snapshot.data!.response!.length,
                        //                     itemBuilder: (context, index) {
                        //
                        //                       String arrivalTime = snapshot.data!.response![index].arrTime  ?? "---";
                        //                       String departureTime = snapshot.data!.response![index].depTime  ?? "---";
                        //                       String arrivalDestination = snapshot.data!.response![index].arrIata ?? "---";
                        //                       String departureDestination = snapshot.data!.response![index].depIata.toString() ?? "---";
                        //                       String flightNo = snapshot.data!.response![index].flightNumber  ?? "---";
                        //                       String flightStatus = snapshot.data!.response![index].status.toString()  ?? "---";
                        //
                        //                       return InkWell(
                        //                         onTap: () async {},
                        //                         child: Padding(
                        //                           padding: EdgeInsets.only(bottom: 20,top: 20),
                        //                           child: Row(
                        //                             mainAxisAlignment:
                        //                             MainAxisAlignment.spaceBetween,
                        //                             children: [
                        //                               Text("$departureTime\n$arrivalTime"),
                        //                               Text("$departureDestination\n$arrivalDestination"),
                        //                               Text("$flightNo\n$flightStatus"),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       );
                        //                     },
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           );
                        //         } else {
                        //           return Center(
                        //             child: Text(
                        //               "error 1${snapshot.error}",
                        //             ),
                        //           );
                        //         }
                        //       } else if (snapshot.hasError) {
                        //         return Center(
                        //           child: Text(
                        //             "error 2${snapshot.error}",
                        //           ),
                        //         );
                        //       } else {
                        //         return Center(child: FunctionProgressIndicator());
                        //       }
                        //     },
                        //
                        //   ),
                        // ),

                        Container(
                          height: h * 0.7,
                          width: w,
                          child: ListView.builder(
                            padding: EdgeInsets.all(20),
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AirlineTrackFlight()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("11:06 AM"),
                                      Text("Dubai, DXB/Karachi, DVC"),
                                      Text("PK 247"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
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
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/airports/model/model_airport_dep_arr.dart';
import 'package:flight_tracker/airports/services/services_airport_arrival.dart';
import 'package:flight_tracker/airports/services/services_airport_departure.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';

import '../../flight_detail/screen/flight_detail_screen.dart';

class AirportScreenDetail extends StatefulWidget {
   AirportScreenDetail({required this.airportName,required this.iataValue}) : super();

   String airportName;
   String iataValue;

  @override
  State<AirportScreenDetail> createState() => _AirportScreenDetailState();
}

class _AirportScreenDetailState extends State<AirportScreenDetail> {

  Future<ModelAirportDepArr>? futureListDeparture;
  Future<ModelAirportDepArr>? futureListArrival;


  @override
  void initState() {
    super.initState();
    setState(() {
      futureListDeparture = ServicesAirportsDeparture().GetAllPosts(widget.iataValue);
      futureListArrival = ServicesAirportsArrival().GetAllPosts(widget.iataValue);
    });
  }


  int index = 0;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.red,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: h * 0.25,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.airportName, style: ThemeTexts.textStyleTitle3.copyWith(fontSize: 10,fontWeight: FontWeight.bold),),
                  background: Container(
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                          image: AssetImage('assets/images/airport.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
              ),

            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
              children: [
                // Container(
                //   height: h * 0.25,
                //   width: w,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(0),
                //     image: DecorationImage(
                //         image: AssetImage('assets/images/airport.jpg'),
                //         fit: BoxFit.fill),
                //   ),
                //   child: Align(
                //       alignment: Alignment.topLeft,
                //       child: IconButton(onPressed: (){
                //         Navigator.pop(context);
                //       }, icon: Icon(Icons.arrow_back,color: Colors.white,))
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(15),
                  // height: h * 0.1,
                  width: w,
                  color: ColorsTheme.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.airportName, style: ThemeTexts.textStyleTitle2),
                      SizedBox(height: 5),
                      Text("Airport", style: ThemeTexts.textStyleTitle3),
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
                                Text("Local Time",
                                    style: ThemeTexts.textStyleTitle2
                                        .copyWith(color: Colors.grey)),
                                Text("Wed 02:56 PM",
                                    style: ThemeTexts.textStyleTitle3
                                        .copyWith(color: Colors.grey)),
                              ],
                            ),
                            Text("86°F",
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
                          container(
                              icon: Icons.assistant_navigation, text: "NAV"),
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
                selectTabs(),
                index == 1
                /// ARRIVAL
                    ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TIME"),
                          SizedBox(width: w * 0.3),
                          Text("DESTINATION"),
                          Text("FLIGHT #"),
                        ],
                      ),
                    ),
                    Container(
                      height: h * 0.7,
                      child: FutureBuilder(
                        future: futureListDeparture,
                        builder: (context,snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.response!.isNotEmpty) {
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(5),
                                        itemCount: snapshot.data!.response!.length,
                                        itemBuilder: (context, index) {

                                          String arrivalTime = snapshot.data!.response![index].arrTime  ?? "---";
                                          String arrivalDestination = snapshot.data!.response![index].airlineIata ?? "---";
                                          String arrivalFlightNo = snapshot.data!.response![index].flightNumber  ?? "---";
                                          String flight_iata = snapshot.data!.response![index].flightIata  ?? "---";

                                          return
                                            InkWell(
                                              onTap: () async {
                                                print("airportscreem $flight_iata");
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return FlightDetailScreen(flight_iata: flight_iata,);
                                                }));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 20,top: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(arrivalTime),
                                                    Text(arrivalDestination),
                                                    Text(arrivalFlightNo),
                                                  ],
                                                ),
                                              ),
                                            );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  "error 1${snapshot.error}",
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "error 2${snapshot.error}",
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(height: 50),
                                FunctionProgressIndicator(),
                              ],
                            );
                          }
                        },

                      ),
                    ),
                  ],
                )
                /// DEPARTURE
                    : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TIME"),
                          SizedBox(width: w * 0.3),
                          Text("DESTINATION"),
                          Text("FLIGHT #"),
                        ],
                      ),
                    ),
                    Container(
                      height: h * 0.7,
                      child: FutureBuilder(
                        future: futureListArrival,
                        builder: (context,snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.response!.isNotEmpty) {
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(5),
                                        itemCount: snapshot.data!.response!.length,
                                        itemBuilder: (context, index) {

                                          String departureTime = snapshot.data!.response![index].depTime  ?? "Unknown";
                                          String departureDestination = snapshot.data!.response![index].airlineIata ?? "Unknown";
                                          String departureFlightNo = snapshot.data!.response![index].flightNumber  ?? "Unknown";
                                          String flight_iata = snapshot.data!.response![index].flightIata  ?? "Unknown";

                                          return
                                            InkWell(
                                              onTap: () async {
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return FlightDetailScreen(flight_iata: flight_iata,);
                                                }));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 20,top: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(departureTime),
                                                    Text(departureDestination),
                                                    Text(departureFlightNo),
                                                  ],
                                                ),
                                              ),
                                            );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  "error 1${snapshot.error}",
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "error 2${snapshot.error}",
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(height: 50),
                                FunctionProgressIndicator(),
                              ],
                            );
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

  Widget selectTabs() {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ReusingWidgets().airlineTapBar(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              context: context,
              text: "DEPARTURES",
              textColor: index == 0 ? ColorsTheme.primaryColor : Colors.grey,
              borderColor: index == 0 ? ColorsTheme.primaryColor : Colors.grey,
              borderWidth: index == 0 ? 3 : 1),
          ReusingWidgets().airlineTapBar(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              context: context,
              text: "ARRIVALS",
              textColor: index == 1 ? ColorsTheme.primaryColor : Colors.grey,
              borderColor: index == 1 ? ColorsTheme.primaryColor : Colors.grey,
              borderWidth: index == 1 ? 3 : 1),
        ],
      ),
    );
  }
}

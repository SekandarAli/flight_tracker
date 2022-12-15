// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/airlines/model/model_airline_detail.dart';
import 'package:flight_tracker/airlines/services/services_airline_details.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import '../../flight_detail/screen/flight_detail_screen.dart';
import '../../functions/function_progress_indicator.dart';

class AirlineScreenDetails extends StatefulWidget {
   AirlineScreenDetails({required this.airlineName,required this.iataValue});

   String airlineName;
   String iataValue;

  @override
  State<AirlineScreenDetails> createState() => _AirlineScreenDetailsState();
}

class _AirlineScreenDetailsState extends State<AirlineScreenDetails> {

  Future<ModelAirlineDetails>? futureList;

  @override
  void initState() {
    super.initState();
    futureList = ServicesAirlineDetails().GetAllPosts(widget.iataValue);
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: h * 0.25,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.airlineName, style: ThemeTexts.textStyleTitle3.copyWith(fontSize: 10,fontWeight: FontWeight.bold),),
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
          child: Stack(
            children: [
              SizedBox(height: 150,),

              // Container(
              //   width: w,
              //   height: h * 0.25,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(0),
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/airport.jpg'),
              //         fit: BoxFit.fill),
              //   ),
              // ),
              SizedBox(height: 150,),
              Container(
                padding: EdgeInsets.all(15),
                width: w,
                decoration: BoxDecoration(
                  color: ColorsTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.airlineName, style: ThemeTexts.textStyleTitle2),
                    SizedBox(height: 5),
                    Text("Airline", style: ThemeTexts.textStyleTitle3),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(20),
                      color: ColorsTheme.themeColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TIME",style: _textStyle()),
                          Text("DEP/ARR",style: _textStyle()),
                          Text("FLIGHT/DATE",style: _textStyle()),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: h * 0.7,
                    //   width: w,
                    //   color: Colors.white,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.all(20),
                    //     itemCount: 50,
                    //     itemBuilder: (context, index) {
                    //       return InkWell(
                    //         onTap: () async {
                    //           Navigator.push(context,
                    //               MaterialPageRoute(builder: (context)=>FlightDetailScreen(flight_iata: "IX142",)));
                    //         },
                    //         child: Padding(
                    //           padding: EdgeInsets.only(bottom: 20,top: 20),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //             MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("11:06 AM"),
                    //               Text("Dubai, DXB/\nKarachi, DVC"),
                    //               Text("PK 247"),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    Container(
                        height: h * 0.7,
                        color: Colors.white,
                        child: FutureBuilder(
                          future: futureList,
                          builder: (context,snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.response!.isNotEmpty) {
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.response!.length,
                                          itemBuilder: (context, index) {

                                            String arrivalTime = snapshot.data!.response![index].arrTime  ?? "---";
                                            String departureTime = snapshot.data!.response![index].depTime  ?? "---";
                                            String arrivalDestination = snapshot.data!.response![index].arrIata ?? "---";
                                            String departureDestination = snapshot.data!.response![index].depIata ?? "---";
                                            String arrivalDestinationShortCode = snapshot.data!.response![index].arrIcao ?? "---";
                                            String departureDestinationShortCode = snapshot.data!.response![index].depIcao ?? "---";
                                            String flightNo = snapshot.data!.response![index].flightNumber  ?? "---";
                                            Object airlineIcao = snapshot.data!.response![index].aircraftIcao  ?? "---";
                                            Object date = snapshot.data!.response![index].updated  ?? "---";
                                            String flight_iata = snapshot.data!.response![index].flightIata  ?? "---";

                                            String dateNow = DateTime.now().toString().substring(0,10);
                                            String dateAirline = date.toString().substring(0,10);

                                            return dateNow == dateAirline ?
                                            InkWell(
                                              onTap: () async {
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return FlightDetailScreen(flight_iata: flight_iata,);
                                                }));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("$departureTime\n$arrivalTime"),
                                                    Text("$departureDestination\n$arrivalDestination"),
                                                    Text("$flightNo\n$dateAirline"),
                                                  ],
                                                ),
                                              ),
                                            ) : Container();
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
                              return Center(child: FunctionProgressIndicator());
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

  TextStyle _textStyle(){
    return ThemeTexts.textStyleTitle2.copyWith(color: Colors.white,);
  }
}

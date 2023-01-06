// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../../../../app_theme/theme_texts.dart';
import '../../../app_theme/color.dart';
import '../../../app_theme/reusing_widgets.dart';
import '../../../flight_detail/model/model_airport_track_screen.dart';
import '../../../flight_detail/screen/flight_detail_screen.dart';
import '../../../flight_detail/services/services_airports_track_screen.dart';

class SearchButtonByFlightCode extends StatefulWidget {
   SearchButtonByFlightCode({required this.flightCode,required this.dateDay,required this.currentDate}) : super();

  var flightCode;
  var dateDay;
  var currentDate;

  @override
  State<SearchButtonByFlightCode> createState() => _SearchButtonByFlightCodeState();
}

class _SearchButtonByFlightCodeState extends State<SearchButtonByFlightCode> {

  Future<ModelAirportTrackScreen>? futureList;

  bool cardExpand = false;
  bool trackFlight = true;

  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  String flightCode = "---";
  String departureCityDate = '---';
  String departureCity = "---";
  String departureCityShortCode = "---";
  String departureCityTime = '---';
  String arrivalCity = "---";
  String arrivalCityShortCode = "---";
  String arrivalCityTime = "---";
  String arrivalCityDate = '---';
  String flightStatus = "---";

  Iterable? hiveFlightCode;

  @override
  void initState() {
    super.initState();
    futureList = ServicesAirportsTrackScreen().GetAllPosts(widget.flightCode);
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  }

  @override
  Widget build(BuildContext context) {
    // print("build");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),),

        actions: [
          Center(child: Text(widget.currentDate.toString())),
          SizedBox(width: 10),
        ],

        title: Text("${widget.flightCode}",style: ThemeTexts.textStyleTitle3,),
      ),

      body: SafeArea(
        child: SizedBox(
          height: h,
          width: w,
          child: FutureBuilder(
            future: futureList,
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.response != null) {
                  flightCode = snapshot.data!.response!.flightIata ?? "---";
                  departureCity = snapshot.data!.response!.depIata ?? "---";
                  arrivalCity = snapshot.data!.response!.arrIata ?? "---";
                  departureCityShortCode = snapshot.data!.response!.depName ?? "---";
                  arrivalCityShortCode = snapshot.data!.response!.arrName ?? "---";
                  String dptTime = snapshot.data!.response!.depTimeTs!.toString().isEmpty ? "" : snapshot.data!.response!.depTimeTs!.toString();
                  departureCityDate = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(dptTime) * 1000));
                  departureCityTime = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(dptTime) * 1000));
                  String arrTime = snapshot.data!.response!.arrTimeTs!.toString().isEmpty ? "" : snapshot.data!.response!.arrTimeTs!.toString();
                  arrivalCityDate = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(arrTime) * 1000));
                  arrivalCityTime = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(arrTime) * 1000));
                  flightStatus = snapshot.data!.response!.status ?? "---";

                  return
                    FlightCardScreen().flightCardWithCardExpand(
                        onTap: (){
                          setState((){
                            cardExpand =! cardExpand;
                          });
                        },
                        context: context,
                        flightCode: flightCode,
                        flightStatus: flightStatus,
                        departureCity: departureCity,
                        departureCityShortCode: departureCityShortCode,
                        departureCityTime: departureCityTime,
                        arrivalCity: arrivalCity,
                        arrivalCityShortCode: arrivalCityShortCode,
                        arrivalCityTime: arrivalCityTime,
                        cardExpandRow: cardExpand == true ?
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: w * 0.3),
                              TextButton(onPressed: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return FlightDetailScreen(flight_iata: flightCode,openTrack: true,);
                                }));

                              },
                                  child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),

                              TextButton(onPressed: () {

                                hiveFlightCode = dataBox!.values.map((e) => e.flightCode);

                                if(hiveFlightCode!.contains(flightCode)){
                                  log("Flight Codes$hiveFlightCode");
                                  ReusingWidgets().snackBar(context: context, text: "Flight Already Tracked");
                                }
                                else{
                                modelMyFlights = ModelMyFlightsUpcoming(
                                    flightCode: flightCode,
                                    departureCity: departureCity,
                                    departureCityShortCode: departureCityShortCode,
                                    departureCityTime: departureCityTime,
                                    arrivalCityDate: arrivalCityDate,
                                    arrivalCity: arrivalCity,
                                    arrivalCityShortCode: arrivalCityShortCode,
                                    arrivalCityTime: arrivalCityTime,
                                    flightStatus: flightStatus,
                                    flightIata: flightCode,
                                    isSelected: false
                                );
                                dataBox!.add(modelMyFlights!);
                                ReusingWidgets().snackBar(context: context, text: "Flight Successfully Tracked");}
                                },
                                  child: Text(trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                            ],
                          ),
                        ) : Container()
                    );
                } else {
                  return NoFlightFound();
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
      ),
    );
  }
}

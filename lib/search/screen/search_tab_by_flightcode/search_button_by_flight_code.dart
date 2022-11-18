// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/search/model/model_search_flights.dart';
import 'package:flight_tracker/search/services/services_search_flight.dart';
import 'package:flutter/material.dart';
import '../../../../app_theme/theme_texts.dart';

class SearchButtonByFlightCode extends StatefulWidget {
   SearchButtonByFlightCode({required this.flightCode}) : super();

  var flightCode;

  @override
  State<SearchButtonByFlightCode> createState() => _SearchButtonByFlightCodeState();
}

class _SearchButtonByFlightCodeState extends State<SearchButtonByFlightCode> {

  String? flightCode;
  var flightStatus;
  String? departureCity;
  String? arrivalCity;
  String? departureCityShortName;
  String? arrivalCityShortName;
  var departureCityTime;
  var arrivalCityTime;

  Future<ModelSearchFlights>? futureList;


  @override
  void initState() {
    super.initState();

    futureList = ServicesSearchFlights().GetAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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

                              flightCode = snapshot.data!.response![index].flightNumber ?? "Unknown";
                              flightStatus = snapshot.data!.response![index].status ?? "Unknown";
                              departureCity = snapshot.data!.response![index].depIata ?? "Unknown";
                              arrivalCity = snapshot.data!.response![index].arrIata ?? "Unknown";
                              departureCityShortName = snapshot.data!.response![index].depIcao ?? "Unknown";
                              arrivalCityShortName = snapshot.data!.response![index].arrIcao ?? "Unknown";
                              departureCityTime = snapshot.data!.response![index].lat ?? "Unknown";
                              arrivalCityTime = snapshot.data!.response![index].lng ?? "Unknown";

                              print("departureairport ${widget.flightCode}");
                              print("departurecity $departureCity");
                              print("arrivalcity $arrivalCity");

                              return
                                widget.flightCode == flightCode ?
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Card(
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey.shade500,
                                                      width: 3
                                                  )
                                              )
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(flightCode!, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
                                              Text(flightStatus.toString(),
                                                  style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black))
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
                                                cityName: departureCity!,
                                                cityShortCode: departureCityShortName!,
                                                cityTime: departureCityTime.toString(),
                                                crossAlignment: CrossAxisAlignment.start,
                                              ),

                                              Icon(Icons.flight_land_rounded, size: 30),

                                              flightDetails(
                                                cityName: arrivalCity!,
                                                cityShortCode: arrivalCityShortName!,
                                                cityTime: arrivalCityTime.toString(),
                                                crossAlignment: CrossAxisAlignment.end,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                    : Container();
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
        Text("$cityName \n$cityShortCode",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black,fontSize: 6)),
        SizedBox(height: 10),
      ],
    );
  }
}

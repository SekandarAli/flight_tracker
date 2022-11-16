// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';
import '../../../../app_theme/theme_texts.dart';
import '../../../model/model_search_flights.dart';
import '../../../services/services_search_flight.dart';

class SearchButtonScreen extends StatefulWidget {
   SearchButtonScreen({required this.departureAirport,required this.arrivalAirport}) : super();

  var departureAirport;
  var arrivalAirport;

  @override
  State<SearchButtonScreen> createState() => _SearchButtonScreenState();
}

class _SearchButtonScreenState extends State<SearchButtonScreen> {

  String? flightCode;
  var flightStatus;
  String? departureCity;
  String? arrivalCity;
  String? departureCityShortName;
  String? arrivalCityShortName;
  var departureCityTime;
  var arrivalCityTime;

  Future<ModelSearchFlights>? futureList;

  bool cardExpand = false;

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
        title: Text("${widget.departureAirport} - ${widget.arrivalAirport}"),
      ),
      body: SafeArea(
        child: SizedBox(
          height: h,
          width: w,
          child: FutureBuilder(
            future: futureList,
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.data!.isNotEmpty) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              flightCode = snapshot.data!.data![index].flight!.number ?? "Unknown";
                              flightStatus = snapshot.data!.data![index].flightStatus ?? "Unknown";
                              departureCity = snapshot.data!.data![index].departure!.airport ?? "Unknown";
                              arrivalCity = snapshot.data!.data![index].arrival!.airport ?? "Unknown";
                              departureCityShortName = snapshot.data!.data![index].departure!.iata ?? "Unknown";
                              arrivalCityShortName = snapshot.data!.data![index].arrival!.iata ?? "Unknown";
                              departureCityTime = snapshot.data!.data![index].flightDate ?? "Unknown";
                              arrivalCityTime = snapshot.data!.data![index].flightDate ?? "Unknown";

                              // flightCode = snapshot.data!.response![index].flightNumber ?? "Unknown";
                              // flightStatus = snapshot.data!.response![index].status ?? "Unknown";
                              // departureCity = snapshot.data!.response![index].depIata ?? "Unknown";
                              // arrivalCity = snapshot.data!.response![index].arrIata ?? "Unknown";
                              // departureCityShortName = snapshot.data!.response![index].depIcao ?? "Unknown";
                              // arrivalCityShortName = snapshot.data!.response![index].arrIcao ?? "Unknown";
                              // departureCityTime = snapshot.data!.response![index].lat ?? "Unknown";
                              // arrivalCityTime = snapshot.data!.response![index].lng ?? "Unknown";

                              print("departureairport ${widget.departureAirport}");
                              print("arrivalairport ${widget.arrivalAirport}");
                              print("departurecity $departureCity");
                              print("arrivalcity $arrivalCity");

                              return
                                widget.departureAirport == departureCity && widget.arrivalAirport == arrivalCity ?
                                InkWell(
                                  onTap: ()  {
                                    setState(() {
                                      cardExpand =! cardExpand;
                                    });
                                  },
                                  child:  Card(
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          color: Colors.grey.shade200,
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
                                        cardExpand == true ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(width: w * 0.3),
                                            TextButton(onPressed: (){

                                              print(departureCity);
                                              print(arrivalCity);
                                            }, child: Text("DETAILS")),
                                            TextButton(onPressed: (){}, child: Text("TRACK FLIGHT")),
                                          ],
                                        ) : Container(),
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

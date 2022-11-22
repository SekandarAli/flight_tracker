// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/search/model/model_search_flights.dart';
import 'package:flight_tracker/search/services/services_search_flight.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../app_theme/theme_texts.dart';

class SearchButtonByRoute extends StatefulWidget {
   SearchButtonByRoute({super.key, required this.departureAirport,required this.arrivalAirport});

  var departureAirport;
  var arrivalAirport;

  @override
  State<SearchButtonByRoute> createState() => _SearchButtonByRouteState();
}

class _SearchButtonByRouteState extends State<SearchButtonByRoute> {

  Future<ModelSearchFlights>? futureList;

  bool cardExpand = false;

  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  @override
  void initState() {
    super.initState();

    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    futureList = ServicesSearchFlights().GetAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.departureAirport} - ${widget.arrivalAirport}",style: ThemeTexts.textStyleTitle3,),
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

                              String flightCode = snapshot.data!.response![index].flightNumber ?? "---";
                              String flightStatus = snapshot.data!.response![index].status.toString() ?? "Unknown";
                              String departureCity = snapshot.data!.response![index].depIata ?? "---";
                              String arrivalCity = snapshot.data!.response![index].arrIata ?? "---";
                              String departureCityShortName = snapshot.data!.response![index].depIcao ?? "---";
                              String arrivalCityShortName = snapshot.data!.response![index].arrIcao ?? "---";
                              String departureCityTime = snapshot.data!.response![index].lat.toString() ?? "Unknown";
                              String arrivalCityTime = snapshot.data!.response![index].lng.toString() ?? "Unknown";
                              String departureCityDate = 'Nov 08, 2022';
                              String arrivalCityDate = 'Nov 09, 2022';

                              return
                                // widget.departureAirport == departureCity && widget.arrivalAirport == arrivalCity ?
                                InkWell(
                                  onTap: (){
                                    setState((){
                                      cardExpand =! cardExpand;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 10),
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
                                                Text(flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
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
                                                  cityName: departureCity,
                                                  cityShortCode: departureCityShortName,
                                                  cityTime: departureCityTime.toString(),
                                                  crossAlignment: CrossAxisAlignment.start,
                                                ),

                                                RotatedBox(quarterTurns: 1,
                                                child: Icon(Icons.flight, size: 35,color: Colors.grey,)),

                                                flightDetails(
                                                  cityName: arrivalCity,
                                                  cityShortCode: arrivalCityShortName,
                                                  cityTime: arrivalCityTime.toString(),
                                                  crossAlignment: CrossAxisAlignment.end,
                                                ),

                                              ],
                                            ),
                                          ),
                                          cardExpand == true ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: w * 0.3),
                                              TextButton(onPressed: () {  }, child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                              TextButton(onPressed: () {

                                                modelMyFlights = ModelMyFlightsUpcoming(
                                                  flightCode: flightCode,
                                                  departureCityDate: departureCityDate,
                                                  departureCity: departureCity,
                                                  departureCityShortCode: departureCityShortName,
                                                  departureCityTime: departureCityTime,
                                                  arrivalCityDate: arrivalCityDate,
                                                  arrivalCity: arrivalCity,
                                                  arrivalCityShortCode: arrivalCityShortName,
                                                  arrivalCityTime: arrivalCityTime,
                                                  flightStatus: flightStatus,
                                                );
                                                dataBox!.add(modelMyFlights!);

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Flight Successfully Tracked'),
                                                        duration: Duration(milliseconds: 1500)));

                                              }, child: Text("TRACK FLIGHT",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                            ],
                                          ) : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                    // : Container();
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
        Text("$cityName - $cityShortCode",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey.shade600)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
      ],
    );
  }
}

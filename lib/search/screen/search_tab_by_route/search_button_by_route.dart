// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../app_theme/theme_texts.dart';
import '../../../flight_detail/screen/flight_detail_screen.dart';
import '../../model/model_search_flight.dart';
import '../../services/services_search_flight.dart';

class SearchButtonByRoute extends StatefulWidget {
   SearchButtonByRoute({
     super.key,
     required this.departureAirport,
     required this.arrivalAirport,
     this.airlineOptional,
     this.dateDay,
   });

  var departureAirport;
  var arrivalAirport;
  var airlineOptional;
  var dateDay;

  @override
  State<SearchButtonByRoute> createState() => _SearchButtonByRouteState();
}

class _SearchButtonByRouteState extends State<SearchButtonByRoute> {

  Future<ModelSearchFlight>? futureList;
  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  bool trackFlight = true;
  bool cardExpand = false;

  @override
  void initState() {
    super.initState();

    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    futureList = ServicesSearchFlight().GetAllPosts(
        depIata: widget.departureAirport,
        arrIata: widget.arrivalAirport,
        airlineIcao: widget.airlineOptional,
        day: widget.dateDay,
        flightIata: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.departureAirport} - ${widget.arrivalAirport}",style: ThemeTexts.textStyleTitle3,),),
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

                              String flightCode = snapshot.data!.response![index].flightIata ?? "---";
                              // Status flightStatus = snapshot.data!.response![index].status!;
                              String departureCity = snapshot.data!.response![index].depIata ?? "---";
                              String airlineShortName = snapshot.data!.response![index].airlineIata ?? "---";
                              String arrivalCity = snapshot.data!.response![index].arrIata ?? "---";
                              String airlineCityOptional = snapshot.data!.response![index].airlineIcao ?? "---";
                              String departureCityShortName = snapshot.data!.response![index].depIcao ?? "---";
                              String arrivalCityShortName = snapshot.data!.response![index].arrIcao ?? "---";
                              String departureCityTime = snapshot.data!.response![index].depTime!;
                              String arrivalCityTime = snapshot.data!.response![index].arrTime!;
                              String flight_iata = snapshot.data!.response![index].flightIata ?? "Unknown";
                              DateTime updated = snapshot.data!.response![index].updated!;
                              List<String> dateDay = snapshot.data!.response![index].days!;



                              // var dateTimeUpdated = DateTime.fromMillisecondsSinceEpoch(updated * 1000);
                              // String departureCityDate = 'Nov 08, 2022';
                              // String arrivalCityDate = 'Nov 09, 2022';
                              // String departureLat = "24.8607";
                              // String departureLng = "67.0011";
                              // String arrivalLat = "31.5204";
                              // String arrivalLng = "74.3587";

                              print("aaaaa${widget.departureAirport}");
                              print("aaaaa${widget.airlineOptional}");
                              print("aaaaa$departureCity");
                              print("aaaaa$airlineCityOptional");
                              print("vvv${widget.dateDay}");
                              print("vvv${dateDay}");
                              print("vvv${dateDay.contains(widget.dateDay)}");


                              return
                                // (widget.departureAirport == departureCity && widget.arrivalAirport == arrivalCity && dateDay.contains(widget.dateDay))
                                    // ||
                                // (widget.departureAirport == departureCity && widget.arrivalAirport == arrivalCity) ||
                              (widget.departureAirport == departureCity && widget.arrivalAirport == arrivalCity && widget.airlineOptional == airlineCityOptional && dateDay.contains(widget.dateDay))
                                    ?
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
                                                color: ColorsTheme.primaryColor,
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
                                                Text(airlineShortName.toString(),
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
                                              TextButton(onPressed: () {

                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return FlightDetailScreen(flight_iata: flight_iata,);
                                                  }));

                                              }, child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                              TextButton(onPressed: () {

                                                // setState((){
                                                //   trackFlight =! trackFlight;
                                                //   if(trackFlight == false){
                                                    modelMyFlights = ModelMyFlightsUpcoming(
                                                        flightCode: flightCode,
                                                        // departureCityDate: departureCityDate,
                                                        departureCity: departureCity,
                                                        departureCityShortCode: departureCityShortName,
                                                        departureCityTime: departureCityTime,
                                                        arrivalCityDate: updated.toString(),
                                                        arrivalCity: arrivalCity,
                                                        arrivalCityShortCode: arrivalCityShortName,
                                                        arrivalCityTime: arrivalCityTime,
                                                        flightStatus: flightCode.toString(),
                                                        // arrivalLat: arrivalLat,
                                                        // arrivalLng: arrivalLng,
                                                        // departureLat: departureLat,
                                                        // departureLng: departureLng,
                                                        flightIata: flight_iata,
                                                        isSelected: false
                                                    );
                                                    dataBox!.add(modelMyFlights!);
                                                    ReusingWidgets().snackBar(context: context, text: "Flight Successfully Tracked");
                                                //   }
                                                //   else{
                                                //     modelMyFlights!.delete();
                                                //   }
                                                // });

                                              }, child: Text(trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                            ],
                                          ) : Container()
                                        ],
                                      ),
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

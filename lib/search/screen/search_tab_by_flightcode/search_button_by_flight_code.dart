// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/search/services/services_search_flight.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../app_theme/theme_texts.dart';
import '../../../app_theme/color.dart';
import '../../../app_theme/reusing_widgets.dart';
import '../../../flight_detail/screen/flight_detail_screen.dart';
import '../../model/model_search_flight.dart';

class SearchButtonByFlightCode extends StatefulWidget {
   SearchButtonByFlightCode({required this.flightCode,required this.dateDay,required this.currentDate}) : super();

  var flightCode;
  var dateDay;
  var currentDate;

  @override
  State<SearchButtonByFlightCode> createState() => _SearchButtonByFlightCodeState();
}

class _SearchButtonByFlightCodeState extends State<SearchButtonByFlightCode> {

  Future<ModelSearchFlight>? futureList;

  bool cardExpand = false;
  bool trackFlight = true;

  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  @override
  void initState() {
    super.initState();
    futureList = ServicesSearchFlight().GetAllPosts(
      depIata: "",
      arrIata: "",
      airlineIcao: "",
      flightIata: widget.flightCode,
      day: widget.dateDay
    );
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                              String arrivalCity = snapshot.data!.response![index].arrIata ?? "---";
                              String airlineCityOptional = snapshot.data!.response![index].airlineIcao ?? "---";
                              String departureCityShortName = snapshot.data!.response![index].depIcao ?? "---";
                              String arrivalCityShortName = snapshot.data!.response![index].arrIcao ?? "---";
                              String departureCityTime = snapshot.data!.response![index].depTime!;
                              String arrivalCityTime = snapshot.data!.response![index].arrTime!;
                              String flight_iata = snapshot.data!.response![index].flightIata ?? "Unknown";
                              DateTime updated = snapshot.data!.response![index].updated!;
                              List<String> dateDay = snapshot.data!.response![index].days!;
                              String airlineShortName = snapshot.data!.response![index].airlineIata ?? "---";

                              print("aaaaa$flightCode");
                              print("aaaaa$dateDay");
                              print("vvv${widget.flightCode}");
                              print("vvv${widget.dateDay}");

                              return
                                (widget.flightCode == flightCode.toLowerCase() || widget.flightCode == flightCode)
                                    && dateDay.contains(widget.dateDay) ?
                                FlightCardScreen().flightCardWithCardExpand(
                                    onTap: (){
                                      setState((){
                                        cardExpand =! cardExpand;
                                      });
                                    },
                                    context: context,
                                    flightCode: flightCode,
                                    flightStatus: airlineShortName.toString(),
                                    departureCity: departureCity,
                                    departureCityShortCode: departureCityShortName,
                                    departureCityTime: departureCityTime,
                                    arrivalCity: arrivalCity,
                                    arrivalCityShortCode: arrivalCityShortName,
                                    arrivalCityTime: arrivalCityTime,
                                    cardExpandRow: cardExpand == true ? Container(
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
                                              return FlightDetailScreen(flight_iata: flight_iata,openTrack: true,);
                                            }));

                                          }, child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                          TextButton(onPressed: () {
                                            modelMyFlights = ModelMyFlightsUpcoming(
                                                flightCode: flightCode,
                                                departureCity: departureCity,
                                                departureCityShortCode: departureCityShortName,
                                                departureCityTime: departureCityTime,
                                                arrivalCityDate: updated.toString(),
                                                arrivalCity: arrivalCity,
                                                arrivalCityShortCode: arrivalCityShortName,
                                                arrivalCityTime: arrivalCityTime,
                                                flightStatus: flightCode.toString(),
                                                flightIata: flight_iata,
                                                isSelected: false
                                            );
                                            dataBox!.add(modelMyFlights!);
                                            ReusingWidgets().snackBar(context: context, text: "Flight Successfully Tracked");
                                          }, child: Text(trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                        ],
                                      ),
                                    ) : Container()
                                )
                                // InkWell(
                                //   onTap: (){
                                //     setState((){
                                //       cardExpand =! cardExpand;
                                //     });
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.only(bottom: 10),
                                //     child: Card(
                                //       elevation: 10,
                                //       child: Column(
                                //         children: [
                                //           Container(
                                //             padding: EdgeInsets.all(15),
                                //             decoration: BoxDecoration(
                                //                 color: ColorsTheme.primaryColor,
                                //                 border: Border(
                                //                     bottom: BorderSide(
                                //                         color: Colors.grey.shade500,
                                //                         width: 3
                                //                     )
                                //                 )
                                //             ),
                                //             child: Row(
                                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //               children: [
                                //                 Text(flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
                                //                 Text(airlineShortName.toString(),
                                //                     style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black))
                                //               ],
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding: EdgeInsets.all(15),
                                //             child: Row(
                                //               mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //               children: [
                                //
                                //                 flightDetails(
                                //                   cityName: departureCity,
                                //                   cityShortCode: departureCityShortName,
                                //                   cityTime: departureCityTime.toString(),
                                //                   crossAlignment: CrossAxisAlignment.start,
                                //                 ),
                                //
                                //                 RotatedBox(quarterTurns: 1,
                                //                     child: Icon(Icons.flight, size: 35,color: Colors.grey,)),
                                //
                                //                 flightDetails(
                                //                   cityName: arrivalCity,
                                //                   cityShortCode: arrivalCityShortName,
                                //                   cityTime: arrivalCityTime.toString(),
                                //                   crossAlignment: CrossAxisAlignment.end,
                                //                 ),
                                //
                                //               ],
                                //             ),
                                //           ),
                                //           cardExpand == true ? Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               SizedBox(width: w * 0.3),
                                //               TextButton(onPressed: () {
                                //
                                //                 Navigator.push(context, MaterialPageRoute(builder: (context){
                                //                   return FlightDetailScreen(flight_iata: flight_iata,);
                                //                 }));
                                //
                                //               }, child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                //               TextButton(onPressed: () {
                                //
                                //                 // setState((){
                                //                 //   trackFlight =! trackFlight;
                                //                 //   if(trackFlight == false){
                                //                 modelMyFlights = ModelMyFlightsUpcoming(
                                //                     flightCode: flightCode,
                                //                     // departureCityDate: departureCityDate,
                                //                     departureCity: departureCity,
                                //                     departureCityShortCode: departureCityShortName,
                                //                     departureCityTime: departureCityTime,
                                //                     arrivalCityDate: updated.toString(),
                                //                     arrivalCity: arrivalCity,
                                //                     arrivalCityShortCode: arrivalCityShortName,
                                //                     arrivalCityTime: arrivalCityTime,
                                //                     flightStatus: flightCode.toString(),
                                //                     // arrivalLat: arrivalLat,
                                //                     // arrivalLng: arrivalLng,
                                //                     // departureLat: departureLat,
                                //                     // departureLng: departureLng,
                                //                     flightIata: flight_iata,
                                //                     isSelected: false
                                //                 );
                                //                 dataBox!.add(modelMyFlights!);
                                //                 ReusingWidgets().snackBar(context: context, text: "Flight Successfully Tracked");
                                //                 //   }
                                //                 //   else{
                                //                 //     modelMyFlights!.delete();
                                //                 //   }
                                //                 // });
                                //
                                //               }, child: Text(trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
                                //             ],
                                //           ) : Container()
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // )


                                    : Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return NoResultFoundScreen();
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

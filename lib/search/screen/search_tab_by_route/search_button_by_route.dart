// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
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
    required this.depIata,
    required this.arrIata,
    this.airlineOptional,
    this.dateDay,
    this.currentDate,
    this.departureAirport,this.arrivalAirport

  });

  var depIata;
  var arrIata;
  var airlineOptional;
  var dateDay;
  var currentDate;
  var departureAirport;
  var arrivalAirport;


  @override
  State<SearchButtonByRoute> createState() => _SearchButtonByRouteState();
}

class _SearchButtonByRouteState extends State<SearchButtonByRoute> {

  Future<ModelSearchFlight>? futureList;
  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  // bool trackFlight = true;
  bool cardExpand = false;

  Iterable? hiveFlightCode;

  @override
  void initState() {
    super.initState();
    // setState((){});
    log(widget.depIata);
    log(widget.arrIata);
    log(widget.airlineOptional);
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    hiveFlightCode = dataBox!.values.map((e) => e.flightCode);
    futureList = ServicesSearchFlight().GetAllPosts(
      depIata: widget.depIata, arrIata: widget.arrIata, airlineIcao: widget.airlineOptional, day: widget.dateDay, flightIata: "",
    );
  }

   refresh() => setState((){});


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     "${widget.departureAirport.length > 12 ? '${widget.departureAirport.substring(0, 12)}...' : widget.departureAirport} - "
      //         "${widget.arrivalAirport.length > 12 ? '${widget.arrivalAirport.substring(0, 12)}...' : widget.arrivalAirport}",
      //
      //     style: ThemeTexts.textStyleTitle3,),
      //   actions: [
      //     Center(child: Text(widget.currentDate.toString())),
      //     SizedBox(width: 10),
      //   ],
      // ),
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
                        AppBar(
                          title: Text(
                            "${widget.departureAirport.length > 12 ? '${widget.departureAirport.substring(0, 12)}...' : widget.departureAirport} - "
                                "${widget.arrivalAirport.length > 12 ? '${widget.arrivalAirport.substring(0, 12)}...' : widget.arrivalAirport}",

                            style: ThemeTexts.textStyleTitle3,),
                          actions: [
                            Center(child: Text(widget.currentDate.toString())),
                            SizedBox(width: 10),
                          ],
                        ),
                        Flexible(
                          child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: snapshot.data!.response!.length,
                            itemBuilder: (context, index) {

                              String flightCode = snapshot.data!.response![index].flightIata ?? "---";
                              String departureCity = snapshot.data!.response![index].depIata ?? "---";
                              String arrivalCity = snapshot.data!.response![index].arrIata ?? "---";
                              String airlineShortName = snapshot.data!.response![index].airlineIata ?? "---";
                              String airlineCityOptional = snapshot.data!.response![index].airlineIcao ?? "---";
                              String departureCityShortName = widget.departureAirport ?? "---";
                              String arrivalCityShortName = widget.arrivalAirport ?? "---";
                              String departureCityTime = snapshot.data!.response![index].depTime ?? "";
                              String arrivalCityTime = snapshot.data!.response![index].arrTime ?? "";
                              String flight_iata = snapshot.data!.response![index].flightIata ?? "";
                              DateTime updated = snapshot.data!.response![index].updated!;
                              List<String> dateDay = snapshot.data!.response![index].days!;

                              return
                                (widget.depIata == departureCity && widget.arrIata == arrivalCity && dateDay.contains(widget.dateDay)) ||
                                    (widget.depIata == departureCity && widget.arrIata == arrivalCity && widget.airlineOptional == airlineCityOptional && dateDay.contains(widget.dateDay)) ?
                                FlightCardScreen().flightCardWithCardExpand(
                                    onTap: (){
                                      setState((){
                                        cardExpand =! cardExpand;
                                        log(cardExpand.toString());
                                      });
                                    },
                                    context: context,
                                    flightCode: flightCode,
                                    flightStatus: "",
                                    departureCity: departureCity,
                                    departureCityShortCode: departureCityShortName,
                                    departureCityTime: departureCityTime,
                                    arrivalCity: arrivalCity,
                                    arrivalCityShortCode: arrivalCityShortName,
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
                                            setState(() {
                                              cardExpand =! cardExpand;
                                            });

                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return FlightDetailScreen(flight_iata: flight_iata);
                                            }));

                                          },
                                              child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.black,fontWeight: FontWeight.bold))),

                                          TextButton(onPressed: () {
                                            var index = -1;
                                            hiveFlightCode = dataBox!.values.map((e) => e.flightCode);
                                            // modelMyFlights = ModelMyFlightsUpcoming(
                                            //   flightCode: flightCode,
                                            //   departureCity: departureCity,
                                            //   departureCityShortCode: departureCityShortName,
                                            //   departureCityTime: departureCityTime,
                                            //   arrivalCityDate: updated.toString(),
                                            //   arrivalCity: arrivalCity,
                                            //   arrivalCityShortCode: arrivalCityShortName,
                                            //   arrivalCityTime: arrivalCityTime,
                                            //   flightStatus: "",
                                            //   flightIata: flight_iata,
                                            //   isSelected: false,
                                            // );
                                            if(hiveFlightCode!.contains(flightCode)){
                                              log("Flight Codes$hiveFlightCode");
                                              for(int i = 0; i < dataBox!.length ; i++){
                                                if(dataBox!.values.elementAt(i).flightCode == flightCode){
                                                  index = i;
                                                }
                                              }
                                              if(index != -1){
                                                dataBox!.deleteAt(index);
                                              }
                                              else{
                                                print("element not found");
                                              }
                                              ReusingWidgets().snackBar(context: context, text: "FLIGHT UNTRACKED");
                                            }
                                            else {
                                              modelMyFlights = ModelMyFlightsUpcoming(
                                                flightCode: flightCode,
                                                departureCity: departureCity,
                                                departureCityShortCode: departureCityShortName,
                                                departureCityTime: departureCityTime,
                                                arrivalCityDate: updated.toString(),
                                                arrivalCity: arrivalCity,
                                                arrivalCityShortCode: arrivalCityShortName,
                                                arrivalCityTime: arrivalCityTime,
                                                flightStatus: "",
                                                flightIata: flight_iata,
                                                isSelected: false,
                                              );
                                              dataBox!.add(modelMyFlights!);
                                              ReusingWidgets().snackBar(context: context, text: "FLIGHT TRACKED");
                                            }
                                            setState(() {});

                                          }, child: Text(
                                              hiveFlightCode != null ?
                                              hiveFlightCode!.contains(flightCode) ?
                                              "UNTRACK FLIGHT": "TRACK FLIGHT" : "null",
                                              style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.black,fontWeight: FontWeight.bold))),
                                        ],
                                      ),
                                    ) : Container()
                                )
                                    : Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  Future(() {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            ReusingWidgets().noResultFoundDialog(context: context));
                  });
                  return Container();
                }
              } else if (snapshot.hasError) {
                return NoInternetError();
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
        required CrossAxisAlignment crossAlignment,
        required TextAlign textAlign,
      }) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAlignment,
      children: [
        Text(cityName,
            style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.black)),
        SizedBox(height: 10),
        Text(cityShortCode,textAlign: textAlign,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.themeColor)),
        SizedBox(height: 10),
      ],
    );
  }
}

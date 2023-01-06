// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:flight_tracker/airlines/model/model_airline_detail.dart';
import 'package:flight_tracker/airlines/services/services_airline_details.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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

  List cityList = [];


  @override
  void dispose() {
    super.dispose();
  }


  String? getCityName(String cityCode){
    String city = '';
    for (int i = 0; i < cityList.length ; i++) {
      if(cityCode == cityList[i]["city_code"]){
        city= cityList[i]["name"];
      }
    }
    return city;
  }

  Future<void> readJsonCity() async {
    final String response = await rootBundle.loadString('assets/json/city.json');
    final data = await json.decode(response);
    setState(() {
      cityList = data["response"];
    });
  }


  @override
  void initState() {
    super.initState();
    print(widget.iataValue);
    futureList = ServicesAirlineDetails().GetAllPosts(widget.iataValue);
    readJsonCity();
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
              expandedHeight: h * 0.3,
              floating: false,
              pinned: true,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },
                  icon: Icon(Icons.arrow_back,color: ColorsTheme.primaryColor,)),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.airlineName, style: ThemeTexts.textStyleTitle3.copyWith(fontSize: 10,fontWeight: FontWeight.bold),),
                background: Container(
                    color: Colors.white,
                    child: Lottie.asset('assets/lottie/createtripbg.json',)),
              ),

            ),
          ];
        },
        body: SingleChildScrollView(
          child: Stack(
            children: [
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
                    Container(
                        height: h * 0.8,
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
                                            String flightNo = snapshot.data!.response![index].flightIata  ?? "---";
                                            Object airlineIcao = snapshot.data!.response![index].aircraftIcao  ?? "---";
                                            String date = snapshot.data!.response![index].updated.toString()  ?? "---";
                                            DateTime y = DateTime.parse(date);
                                            final DateFormat formatter = DateFormat('dd-MM-yyyy');


                                            String flight_iata = snapshot.data!.response![index].flightIata  ?? "---";

                                            String dateNow = DateTime.now().toString().substring(0,10);
                                            String dateYesterday = DateTime.now().subtract(Duration(days:1)).toString().substring(0,10);
                                            String dateAirline = date.toString().substring(0,10);

                                            // return dateNow == dateAirline || dateYesterday == dateAirline ?
                                            return dateNow == dateAirline ?
                                             InkWell(
                                              onTap: () async {
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return FlightDetailScreen(flight_iata: flight_iata,openTrack: true,);
                                                }));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("$departureTime\n$arrivalTime"),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("${getCityName(departureDestination)}",style: ThemeTexts.textStyleTitle2Black,),
                                                        Text("${getCityName(arrivalDestination)}",style: ThemeTexts.textStyleTitle2Black,),
                                                      ],
                                                    ),
                                                    Text("$flightNo\n${formatter.format(y)}"),
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
                                return Center(child: NoFlightFound());
                              }
                            } else if (snapshot.hasError) {
                              return NoInternetError();
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

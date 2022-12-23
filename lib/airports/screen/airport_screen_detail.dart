// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/airports/model/model_airport_dep_arr.dart';
import 'package:flight_tracker/airports/services/services_airport_arrival.dart';
import 'package:flight_tracker/airports/services/services_airport_departure.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
              expandedHeight: h * 0.3,
              floating: false,
              pinned: true,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: ColorsTheme.primaryColor,)),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.airportName, style: ThemeTexts.textStyleTitle3.copyWith(fontSize: 10,fontWeight: FontWeight.bold),),
                  background: Container(
                    color: Colors.white,
                      child: Lottie.asset('assets/lottie/createtripbg.json',)),
              ),

            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
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
                  selectTabs(),
                  index == 1
                  /// ARRIVAL
                      ? Container(
                        height: h * 0.7,
                        child: FutureBuilder(
                          future: futureListDeparture,
                          builder: (context,snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.response!.isNotEmpty) {
                                return Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(5),
                                    itemCount: snapshot.data!.response!.length,
                                    itemBuilder: (context, index) {

                                      String arrivalTime = snapshot.data!.response![index].arrTime  ?? "---";
                                      String arrivalDestination = snapshot.data!.response![index].airlineIata ?? "---";
                                      String arrivalFlightNo = snapshot.data!.response![index].flightNumber  ?? "---";
                                      String flight_iata = snapshot.data!.response![index].flightIata  ?? "---";

                                      return
                                        cardContainer(
                                            departureTime: arrivalTime,
                                            departureDestination: arrivalDestination,
                                            departureFlightNo: flight_iata,
                                            onTap: ()async {
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return FlightDetailScreen(flight_iata: flight_iata,openTrack: true,);
                                              }));
                                            });
                                    },
                                  ),
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
                              return Column(
                                children: [
                                  SizedBox(height: 50),
                                  FunctionProgressIndicator(),
                                ],
                              );
                            }
                          },

                        ),
                      )
                  /// DEPARTURE
                      : Container(
                        height: h * 0.7,
                        child: FutureBuilder(
                          future: futureListArrival,
                          builder: (context,snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.response!.isNotEmpty) {
                                return Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(5),
                                    itemCount: snapshot.data!.response!.length,
                                    itemBuilder: (context, index) {

                                      String departureTime = snapshot.data!.response![index].depTime  ?? "Unknown";
                                      String departureDestination = snapshot.data!.response![index].airlineIata ?? "Unknown";
                                      String departureFlightNo = snapshot.data!.response![index].flightIata  ?? "Unknown";
                                      String flight_iata = snapshot.data!.response![index].flightIata  ?? "Unknown";

                                      return
                                        cardContainer(
                                            departureTime: departureTime,
                                            departureDestination: departureDestination,
                                            departureFlightNo: departureFlightNo,
                                            onTap: ()async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return FlightDetailScreen(flight_iata: flight_iata,openTrack: true,);
                                          }));
                                        });
                                    },
                                  ),
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
          ),
        ),
      ),
    );
  }

  Widget selectTabs() {
    return Container(
      color: ColorsTheme.themeColor,
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
              textColor: index == 0 ? Colors.white : ColorsTheme.lightGreyColor,
              borderColor: index == 0 ? ColorsTheme.lightThemeColor : ColorsTheme.themeColor,
              borderWidth: index == 0 ? 5 : 1),
          ReusingWidgets().airlineTapBar(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              context: context,
              text: "ARRIVALS",
              textColor: index == 1 ? Colors.white : ColorsTheme.lightGreyColor,
              borderColor: index == 1 ? ColorsTheme.lightThemeColor : ColorsTheme.themeColor,
              borderWidth: index == 1 ? 5 : 1),
        ],
      ),
    );
  }

  cardRow({
    required String title,
    required String subTitle,
}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(subTitle),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Divider(
                    thickness: 2,
                    color: ColorsTheme.themeColor,
                  )),
            ],
          ),
        ],
    );
  }

  cardContainer({
    required Function() onTap,
    required String departureTime,
    required String departureDestination,
    required String departureFlightNo,
}) {
    return InkWell(
        onTap: () async {
          onTap();
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.all(
                  Radius.circular(10)
                ),
                border: Border.all(width: 1,color: Colors.grey)
              ),
              child: Column(
                children: [
                  cardRow(title: "TIME", subTitle: departureTime),
                  SizedBox(height: 10),
                  cardRow(title: "DESTINATION", subTitle: departureDestination),
                  SizedBox(height: 10),
                  cardRow(title: "FLIGHT #", subTitle: departureFlightNo),
                ],
              ),
            ),
            SizedBox(height: 10)
          ],
        )
    );
  }
}

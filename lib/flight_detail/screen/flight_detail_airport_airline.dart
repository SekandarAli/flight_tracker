// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/flight_detail/model/model_airport_track_screen.dart';
import 'package:flight_tracker/flight_detail/services/services_airports_track_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/dummy/polygon_main.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';


class FlightDetailAirportAirline extends StatefulWidget {
  FlightDetailAirportAirline({super.key, this.flight_iata});
  String? flight_iata;

  @override
  State<FlightDetailAirportAirline> createState() => _FlightDetailAirportAirlineState();
}

class _FlightDetailAirportAirlineState extends State<FlightDetailAirportAirline> {

  bool trackFlight = true;
  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  Future<ModelAirportTrackScreen>? futureList;

  String flightCode = "---";
  String departureCityDate = '---';
  String departureCity = "---";
  String departureCityShortCode = "---";
  String departureCityTime = '---';
  String arrivalCity = "---";
  String arrivalCityShortCode = "---";
  String arrivalCityTime = "---";
  String arrivalCityDate = '---';
  String departureLat = "24.8607";
  String departureLng = "67.0011";
  String arrivalLat = "31.5204";
  String arrivalLng = "74.3587";
  String departureTerminal = "---";
  String arrivalTerminal = "---";
  String departureGate = "---";
  String arrivalGate = "---";
  String distance = "---";
  String duration = "---";
  String flightTimeLeft = "---";
  String baggage = "---";
  String departureAirport = "---";
  String arrivalAirport = "---";
  String flightStatus = "---";

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
    widget.flight_iata != null ? futureList = ServicesAirportsTrackScreen().GetAllPosts(widget.flight_iata!) : null;
  }

  @override
  Widget build(BuildContext context) {

    return widget.flight_iata == null ?
    Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.no_backpack_outlined,size: 50,),
              SizedBox(height: 20,),
              Text("Oops! No Data Found"),
              ReusingWidgets.searchButton(onPress: (){Navigator.pop(context);}, context: context,text: "BACK")
            ],
          ),
        )) : Scaffold(
      bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text(
                    trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",
                    style: ThemeTexts.textStyleTitle3.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.normal)),
                onPressed: () {
                  setState(() {
                    trackFlight = !trackFlight;

                    if (trackFlight == false) {
                      modelMyFlights = ModelMyFlightsUpcoming(
                          flightCode: flightCode,
                          departureCityDate: departureCityDate,
                          departureCity: departureCity,
                          departureCityShortCode: departureCityShortCode,
                          departureCityTime: departureLat,
                          arrivalCityDate: departureCityDate,
                          arrivalCity: arrivalCity,
                          arrivalCityShortCode: arrivalCityShortCode,
                          arrivalCityTime: departureLng,
                          departureLat: departureLat,
                          departureLng: departureLng,
                          arrivalLat: arrivalLat,
                          arrivalLng: arrivalLng,
                          departureTerminal: departureTerminal,
                          departureAirport: departureAirport,
                          departureGate: departureGate,
                          arrivalGate: arrivalGate,
                          duration: duration,
                          distance: distance,
                          flightTimeLeft: flightTimeLeft,
                          baggage: baggage,
                          arrivalAirport: arrivalAirport,
                          arrivalTerminal: arrivalTerminal,
                          flightStatus: flightStatus
                      );

                      dataBox!.add(modelMyFlights!);
                      print(modelMyFlights!.arrivalCity);
                    }

                    else {
                      modelMyFlights!.delete();
                    }
                  });
                },
              ),
              TextButton(
                child: Text("ADD TO TRIPS",
                    style: ThemeTexts.textStyleTitle3.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.normal)),
                onPressed: () {},
              ),
            ],
          )),
      body: FutureBuilder(
          future: futureList,
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.response != null) {
                flightCode = snapshot.data!.response!.flightNumber ?? "---";
                departureCity = snapshot.data!.response!.depCity ?? "---";
                arrivalCity = snapshot.data!.response!.arrCity ?? "---";
                departureCityShortCode = snapshot.data!.response!.depCountry ?? "---";
                arrivalCityShortCode = snapshot.data!.response!.arrCountry ?? "---";
                // departureCityTime = snapshot.data!.response!.arrCountry ?? "---";
                // arrivalCityTime = snapshot.data!.response!.arrCountry ?? "---";
                departureCityDate = snapshot.data!.response!.depTime ?? "---";
                arrivalCityDate = snapshot.data!.response!.arrTime ?? "---";
                // departureLat = snapshot.data!.response!.arrTime ?? "---";
                // departureLng = snapshot.data!.response!.arrTime ?? "---";
                // arrivalLat = snapshot.data!.response!.arrTime ?? "---";
                // arrivalLng = snapshot.data!.response!.arrTime ?? "---";
                departureTerminal = snapshot.data!.response!.depTerminal ?? "---";
                arrivalTerminal = snapshot.data!.response!.arrTerminal ?? "---";
                departureGate = snapshot.data!.response!.depGate ?? "---";
                arrivalGate = snapshot.data!.response!.arrGate ?? "---";
                distance = snapshot.data!.response!.updated.toString() ?? "---";
                duration = snapshot.data!.response!.duration.toString() ?? "---";
                flightTimeLeft = snapshot.data!.response!.flag ?? "---";
                baggage = snapshot.data!.response!.arrBaggage ?? "---";
                departureAirport = snapshot.data!.response!.depName ?? "---";
                arrivalAirport = snapshot.data!.response!.arrName ?? "---";
                flightStatus = snapshot.data!.response!.status ?? "---";

                return Stack(
                  children: [
                    CustomGoogleMaps(
                      departureLng: double.parse(departureLng),
                      departureLat: double.parse(departureLat),
                      arrivalLat: double.parse(arrivalLat),
                      arrivalLng: double.parse(arrivalLng),
                    ),
                    CustomMapsButton(),
                    DraggableScrollableSheet(
                      initialChildSize: 0.45,
                      minChildSize: 0.15,
                      snap: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: CustomScrollViewContent(),
                        );
                      },
                    ),
                  ],
                );
              }
              else {
                return Center(
                  child: Text(
                    "error 1${snapshot.error}",
                  ),
                );
              }
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "error 2${snapshot.error}",
                ),
              );
            } else {
              return Center(child: FunctionProgressIndicator());
            }
          }
      ),
    );
  }

  Widget CustomMapsButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Widget CustomScrollViewContent() {
    return Card(
      color: Colors.white,
      elevation: 12.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      margin: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            SizedBox(height: 12),
            CustomDraggingHandle(),
            SizedBox(height: 10),
            CustomFlightName(),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 16),
            CustomFlightCountryNameRow(),
            SizedBox(height: 24),
            CustomTerminalGate(),
            SizedBox(height: 24),
            CustomDistanceDurationRow(),
            SizedBox(height: 24),
            CustomBaggageClaim(baggage: baggage),
            SizedBox(height: 24),
            CustomSeatAircraftInfo(context: context),
            SizedBox(height: 20),
            CustomAirportDetails(context: context,airportName: departureAirport,depOrArr: "Departure Airport",time: departureCityDate),
            SizedBox(height: 20),
            CustomAirportDetails(context: context,airportName: arrivalAirport,depOrArr: "Arrival Airport",time: arrivalCityDate)
          ],
        ),
      ),
    );
  }

  Widget CustomDraggingHandle() {
    return Container(
      height: 5,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget CustomFlightName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          color: ColorsTheme.primaryColor,
          child: Text(flightCode,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
        ),
        Text(flightStatus,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
      ],
    );
  }

  Widget CustomFlightCountryName({
    required String cityName,
    required String cityShortCode,
    required String cityTime,
    required String cityDate,
    required CrossAxisAlignment crossAlignment
  }) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAlignment,
      children: [
        Text(cityName,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityShortCode,
            style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.black)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text("🗓️ $cityDate",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey,fontSize: 8)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget CustomFlightCountryNameRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomFlightCountryName(
              cityName: departureCity,
              cityShortCode: departureCityShortCode,
              cityTime: departureLat,
              cityDate: departureCityDate,
              crossAlignment: CrossAxisAlignment.start),
          RotatedBox(quarterTurns: 1,
              child: Icon(Icons.flight, size: 40,color: Colors.grey,)),
          CustomFlightCountryName(
              cityName: arrivalCity,
              cityShortCode: arrivalCityShortCode,
              cityTime: departureLng,
              cityDate: arrivalCityDate,
              crossAlignment: CrossAxisAlignment.end),
        ],
      ),
    );
  }

  Widget CustomTerminalGate() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomTerminalgateRow(text: "Terminal",container: departureTerminal ),
              SizedBox(width: 10),
              CustomTerminalgateRow(text: "Gate",container: departureGate ),
            ],
          ),
          Row(
            children: [
              CustomTerminalgateRow(text: "Terminal",container: arrivalTerminal ),
              SizedBox(width: 10),
              CustomTerminalgateRow(text: "Gate",container: arrivalGate ),
            ],
          ),

        ],
      ),
    );
  }

  Widget CustomTerminalgateRow({
    required String text,
    required String container,
  }) {
    return Column(
      children: [
        Text(text,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 7),
          color: Colors.grey,
          child:  Text(container,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
        )
      ],
    );
  }


  Widget CustomDistanceDuration({
    required String text,
    required String detail,
  }) {
    return Column(
      children: [
        Text(text,
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(detail,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black)),
      ],
    );
  }

  Widget CustomDistanceDurationRow() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDistanceDuration(text: "Distance",detail: distance),
          CustomDistanceDuration(text: "Duration",detail: duration),
          CustomDistanceDuration(text: "Flag",detail: flightTimeLeft),
        ],
      ),
    );
  }

  Widget CustomBaggageClaim(
      {
        required String baggage,
      }
      ) {
    return Container(
      // height: double.infinity / 2,
      color: ColorsTheme.primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Baggage Claim",
                style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 7),
              color: Colors.white,
              child:  Text(baggage,
                  style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Widget CustomSeatAircraftInfo({required BuildContext context}) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child:
              Image.asset("assets/images/airline.png", fit: BoxFit.cover)),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Seat Map",
                        style: ThemeTexts.textStyleTitle2.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    Text("Airplane",
                        style: ThemeTexts.textStyleTitle3
                            .copyWith(color: Colors.black)),
                    SizedBox(height: 5),
                  ],
                ),
                TextButton(
                  child: Text("Info",
                      style: ThemeTexts.textStyleTitle2.copyWith(
                          color: ColorsTheme.primaryColor,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CustomAirportDetails({
    required BuildContext context,
    required String airportName,
    required String depOrArr,
    required String time,
  }) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.25,
            width: w,
            child: Image.asset('assets/images/airport.jpg', fit: BoxFit.fill),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: w,
            color: ColorsTheme.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(airportName,
                    style: ThemeTexts.textStyleTitle2
                        .copyWith(color: Colors.black)),
                SizedBox(height: 5),
              ],
            ),
          ),
          Container(
            width: w,
            color: ColorsTheme.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(depOrArr,
                              style: ThemeTexts.textStyleTitle2
                                  .copyWith(color: Colors.grey)),
                          Text("Local Time: $time",
                              style: ThemeTexts.textStyleTitle3
                                  .copyWith(color: Colors.grey)),
                        ],
                      ),
                      Text("86°C",
                          style: ThemeTexts.textStyleTitle1
                              .copyWith(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    container(icon: Icons.info, text: "INFO"),
                    container(icon: Icons.assistant_navigation, text: "NAV"),
                    container(
                        icon: Icons.sports_baseball_rounded, text: "WEBSITE"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget container({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: ColorsTheme.primaryColor,
          ),
          SizedBox(height: 5),
          Text(text,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/dummy/polygon_main.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../app_theme/reusing_widgets.dart';

class MyFlightsOpenUpComingFlights extends StatefulWidget {
    MyFlightsOpenUpComingFlights({super.key, required this.modelMyFlightsUpcoming});

    ModelMyFlightsUpcoming modelMyFlightsUpcoming;

  @override
  State<MyFlightsOpenUpComingFlights> createState() => _MyFlightsOpenUpComingFlightsState();
}

class _MyFlightsOpenUpComingFlightsState extends State<MyFlightsOpenUpComingFlights> {

  bool trackFlight = true;
  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text(
                    // trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",
                    "TRACK FLIGHT",
                    style: ThemeTexts.textStyleTitle3.copyWith(
                        color: ColorsTheme.primaryColor,
                        fontWeight: FontWeight.normal)),
                onPressed: () {
                  ReusingWidgets().snackBar(context: context, text: 'Flight is Already Tracked');
                  // setState(() {
                  //   trackFlight = !trackFlight;
                  //
                  //   if (trackFlight == false) {
                  //     modelMyFlights = ModelMyFlightsUpcoming(
                  //       flightCode: widget.modelMyFlightsUpcoming.flightCode,
                  //       departureCityDate: widget.modelMyFlightsUpcoming.departureCityDate,
                  //       departureCity: widget.modelMyFlightsUpcoming.departureCity,
                  //       departureCityShortCode: widget.modelMyFlightsUpcoming.departureCityShortCode,
                  //       departureCityTime: widget.modelMyFlightsUpcoming.departureCityTime,
                  //       arrivalCityDate: widget.modelMyFlightsUpcoming.departureCityDate,
                  //       arrivalCity: widget.modelMyFlightsUpcoming.arrivalCity,
                  //       arrivalCityShortCode: widget.modelMyFlightsUpcoming.arrivalCityShortCode,
                  //       arrivalCityTime: widget.modelMyFlightsUpcoming.arrivalCityTime,
                  //       flightStatus: widget.modelMyFlightsUpcoming.flightStatus
                  //     );
                  //
                  //     dataBox!.add(modelMyFlights!);
                  //     print(modelMyFlights!.arrivalCity);
                  //   }
                  //
                  //   else {
                  //     modelMyFlights!.delete();
                  //   }
                  // });
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
      body: Stack(
        children: [
          CustomGoogleMaps(
            departureLat: double.parse(widget.modelMyFlightsUpcoming.departureLat!),
            departureLng:double.parse(widget.modelMyFlightsUpcoming.departureLng!),
            arrivalLat: double.parse(widget.modelMyFlightsUpcoming.arrivalLat!),
            arrivalLng: double.parse(widget.modelMyFlightsUpcoming.arrivalLng!),
          ),
          CustomMapsButton(),
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.15,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: CustomScrollViewContent(),
              );
            },
          ),
        ],
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
            CustomBaggageClaim(baggage: widget.modelMyFlightsUpcoming.baggage!),
            SizedBox(height: 24),
            CustomSeatAircraftInfo(context: context),
            SizedBox(height: 20),
            CustomAirportDetails(context: context,airportName: widget.modelMyFlightsUpcoming.departureAirport!,depOrArr: "Departure Airport",time: widget.modelMyFlightsUpcoming.departureCityDate),
            SizedBox(height: 20),
            CustomAirportDetails(context: context,airportName: widget.modelMyFlightsUpcoming.arrivalAirport!,depOrArr: "Arrival Airport",time: widget.modelMyFlightsUpcoming.arrivalCityDate)
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
          child: Text(widget.modelMyFlightsUpcoming.flightCode,
              style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
        ),
        Text(widget.modelMyFlightsUpcoming.flightStatus!,
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
              cityName: widget.modelMyFlightsUpcoming.departureCity,
              cityShortCode: widget.modelMyFlightsUpcoming.departureCityShortCode,
              cityTime: widget.modelMyFlightsUpcoming.departureLat!,
              cityDate: widget.modelMyFlightsUpcoming.departureCityDate,
              crossAlignment: CrossAxisAlignment.start),
          RotatedBox(quarterTurns: 1,
              child: Icon(Icons.flight, size: 40,color: Colors.grey,)),
          CustomFlightCountryName(
              cityName: widget.modelMyFlightsUpcoming.arrivalCity,
              cityShortCode: widget.modelMyFlightsUpcoming.arrivalCityShortCode,
              cityTime: widget.modelMyFlightsUpcoming.departureLng!,
              cityDate: widget.modelMyFlightsUpcoming.arrivalCityDate,
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
              CustomTerminalgateRow(text: "Terminal",container: widget.modelMyFlightsUpcoming.departureTerminal! ),
              SizedBox(width: 10),
              CustomTerminalgateRow(text: "Gate",container: widget.modelMyFlightsUpcoming.departureGate! ),
            ],
          ),
          Row(
            children: [
              CustomTerminalgateRow(text: "Terminal",container: widget.modelMyFlightsUpcoming.arrivalTerminal! ),
              SizedBox(width: 10),
              CustomTerminalgateRow(text: "Gate",container: widget.modelMyFlightsUpcoming.arrivalGate! ),
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
          CustomDistanceDuration(text: "Distance",detail: widget.modelMyFlightsUpcoming.distance!),
          CustomDistanceDuration(text: "Duration",detail: widget.modelMyFlightsUpcoming.duration!),
          CustomDistanceDuration(text: "Flag",detail: widget.modelMyFlightsUpcoming.flightTimeLeft!),
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

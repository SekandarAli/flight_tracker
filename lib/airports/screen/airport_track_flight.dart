// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';


class AirportTrackFlight extends StatefulWidget {
  const AirportTrackFlight({super.key});

  @override
  State<AirportTrackFlight> createState() => _AirportTrackFlightState();
}

class _AirportTrackFlightState extends State<AirportTrackFlight> {

  bool trackFlight = true;
  Box<ModelMyFlightsUpcoming>? dataBox;
  ModelMyFlightsUpcoming? modelMyFlights;

  String flightCode = "PK 3309";
  String departureCityDate = 'Nov 08, 2022';
  String departureCity = "Islamabad";
  String departureCityShortCode = "ISL";
  String departureCityTime = '09:30 AM';
  String arrivalCity = "Lahore";
  String arrivalCityShortCode = "LHR";
  String arrivalCityTime = "12:50 PM";
  String arrivalCityDate = 'Nov 09, 2022';


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
                        departureCityTime: departureCityTime,
                        arrivalCityDate: departureCityDate,
                        arrivalCity: arrivalCity,
                        arrivalCityShortCode: arrivalCityShortCode,
                        arrivalCityTime: arrivalCityTime,
                      );

                      dataBox!.add(modelMyFlights!);
                      print(modelMyFlights!.arrivalCity);
                    }

                    else {
                      // modelMyFlights!.delete();
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
      body: Stack(
        children: [
          CustomGoogleMap(),
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

  Widget CustomGoogleMap() {

    final Set<Polyline> polyline = {};
    GoogleMapController controller;

    Set<Marker> markers = {}; //markers for google map

    LatLng startLocation = LatLng(33.6844, 73.0479);
    LatLng endLocation = LatLng(33.6844, 73.0479);



    void _onMapCreated(GoogleMapController controllerParam) {
      setState(() {
        controller = controllerParam;
        markers.add(Marker(
          markerId: MarkerId(startLocation.toString()),
          position: startLocation,
          infoWindow: InfoWindow(
            title: 'Starting Point ',
            snippet: 'Start Marker',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));

        polyline.add(Polyline(
          polylineId: PolylineId('line1'),
          visible: true,
          points: [LatLng(33.6844, 73.0479),LatLng(33.6844, 73.0479)],
          width: 2,
          color: Colors.blue,
        ));
      });
    }

    return GoogleMap(
      polylines: polyline,
      markers: markers,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: endLocation,
        zoom: 14.0,
      ),
      mapType: MapType.normal,
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
            CustomDistanceDurationRow(),
            SizedBox(height: 24),
            CustomSeatAircraftInfo(context: context),
            SizedBox(height: 20),
            CustomSeatAircraftInfo(context: context),
            SizedBox(height: 20),
            CustomAirportDetails(context: context),
            SizedBox(height: 20),
            CustomAirportDetails(context: context)
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
        Text("Scheduled",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
      ],
    );
  }

  Widget CustomFlightCountryName({
      required String cityName,
      required String cityShortCode,
      required String cityTime,
      required String cityDate,
      required CrossAxisAlignment crossAlignment}) {
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
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
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
              cityTime: departureCityTime,
              cityDate: departureCityDate,
              crossAlignment: CrossAxisAlignment.start),
          Icon(Icons.flight_land_rounded, size: 50),
          CustomFlightCountryName(
              cityName: arrivalCity,
              cityShortCode: arrivalCityShortCode,
              cityTime: arrivalCityTime,
              cityDate: arrivalCityDate,
              crossAlignment: CrossAxisAlignment.end),
        ],
      ),
    );
  }

  Widget CustomDistanceDuration() {
    return Column(
      children: [
        Text("Distance",
            style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text("977 mi",
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black)),
      ],
    );
  }

  Widget CustomDistanceDurationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDistanceDuration(),
          CustomDistanceDuration(),
          CustomDistanceDuration(),
        ],
      ),
    );
  }

  Widget CustomSeatAircraftInfo({required BuildContext context}) {
    return Card(
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

  Widget CustomAirportDetails({required BuildContext context}) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Card(
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
                Text("Airport Name",
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
                          Text("Departure Airport",
                              style: ThemeTexts.textStyleTitle2
                                  .copyWith(color: Colors.grey)),
                          Text("Local Time: Wed 02:56 PM",
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

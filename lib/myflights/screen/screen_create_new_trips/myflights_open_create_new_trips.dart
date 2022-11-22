// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightsOpenCreateNewTrips extends StatefulWidget {
   MyFlightsOpenCreateNewTrips({Key? key,required this.noOfFlights,required this.tripName}) : super(key: key);

   String noOfFlights;
   String tripName;

  @override
  State<MyFlightsOpenCreateNewTrips> createState() => _MyFlightsOpenCreateNewTripsState();
}

class _MyFlightsOpenCreateNewTripsState extends State<MyFlightsOpenCreateNewTrips> {

  ModelMyFlightsCreateTrip? modelMyFlightsCreateTrip;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: h * 0.25,
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/airline.png'),
                      fit: BoxFit.fill),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back,color: Colors.white,))
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(onPressed: (){

                        }, icon: Icon(Icons.more_vert,color: Colors.white,))
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                // height: h * 0.1,
                width: w,
                color: ColorsTheme.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.tripName, style: ThemeTexts.textStyleTitle2),
                    SizedBox(height: 5),
                    Text("My Trip", style: ThemeTexts.textStyleTitle3),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.flight),
                        SizedBox(width: 10,),
                        Text("Flights"),
                      ],
                    ),
                  ),
                  Container(
                    height: h * 0.7,
                    width: w,
                    child: ValueListenableBuilder<Box<ModelMyFlightsCreateTrip>>(
                      valueListenable:
                      Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip").listenable(),
                      builder: (context, box, _) {

                        final items = box.values.toList().cast<ModelMyFlightsCreateTrip>();

                        if (items.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.flight,
                                    size: w * 0.4,
                                    color: Colors.grey,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "No Flights Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: w * 0.1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: box.values.length,
                                    itemBuilder: (context, index) {
                                      ModelMyFlightsCreateTrip? currentTask = box.getAt(index);
                                      return currentTask!.modelMyFlightsUpcoming!.flightCode.isNotEmpty ?
                                      Dismissible(
                                        key: Key(
                                            UniqueKey().toString()),
                                        background: Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(15),
                                          color: Colors.red.shade800,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.delete,color: Colors.white,),
                                              Icon(Icons.delete,color: Colors.white,),
                                            ],
                                          ),
                                        ),
                                        onDismissed: (direction){
                                          setState(() {
                                            currentTask.delete();
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Flight Removed Successfully'),duration: Duration(milliseconds: 700)));
                                        },
                                        child: Card(
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15),
                                                color: ColorsTheme.primaryColor,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(currentTask.modelMyFlightsUpcoming!.flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
                                                    Text(currentTask.modelMyFlightsUpcoming!.flightStatus, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(15),
                                                color: Colors.grey.shade100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Text("🗓️ ${currentTask.modelMyFlightsUpcoming!.departureCityDate}",
                                                        style: ThemeTexts.textStyleTitle3
                                                            .copyWith(
                                                            color: Colors.black87)),
                                                    Text("🗓️ ${currentTask.modelMyFlightsUpcoming!.arrivalCityDate}",
                                                        style: ThemeTexts.textStyleTitle3
                                                            .copyWith(
                                                            color: Colors.black87)),
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
                                                        cityName: currentTask.modelMyFlightsUpcoming!.departureCity,
                                                        cityShortCode: currentTask.modelMyFlightsUpcoming!.departureCityShortCode,
                                                        cityTime: currentTask.modelMyFlightsUpcoming!.departureCityTime,
                                                        crossAlignment: CrossAxisAlignment.start),

                                                    RotatedBox(
                                                      quarterTurns: 1,
                                                      child: Icon(
                                                        Icons.flight,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      ),
                                                    ),

                                                    flightDetails(
                                                        cityName: currentTask.modelMyFlightsUpcoming!.arrivalCity,
                                                        cityShortCode: currentTask.modelMyFlightsUpcoming!.arrivalCityShortCode,
                                                        cityTime: currentTask.modelMyFlightsUpcoming!.arrivalCityTime,
                                                        crossAlignment: CrossAxisAlignment.end),

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ) : Container();
                                    },
                                  ),
                                ),
                              ]
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget container({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.all(10),
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

  Widget flightDetails(
      {required String cityName,
        required String cityShortCode,
        required String cityTime,
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
      ],
    );
  }

}

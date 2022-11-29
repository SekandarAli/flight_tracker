// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/modelnew.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightCreateNewTrip extends StatefulWidget {
  MyFlightCreateNewTrip({Key? key, this.tripName}) : super(key: key);

  String? tripName;

  @override
  State<MyFlightCreateNewTrip> createState() => _MyFlightCreateNewTripState();
}

class _MyFlightCreateNewTripState extends State<MyFlightCreateNewTrip> {
  Box<ModelMyFlightsCreateTrip>? dataBox;
  ModelMyFlightsCreateTrip? modelMyFlights;
  ModelMyFlightsCreateTrip? modelMyFlightsDummy;

  // ModelNew? newTask;

  List<ModelMyFlightsUpcoming> selectedItems = [];
  List<ModelMyFlightsUpcoming> getSelectedItems() => selectedItems;

  int count = 0;
  String noOfFlights = '0';
  String tripImage = "Image";
  List<bool> isChecked = List.generate(10, (index) => false);


  var finalItemsList = [];

  ModelMyFlightsCreateTrip? modelMyFlightsCreateTrip;

  // Box<ModelNew>? taskBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
    // taskBox = Hive.box<ModelNew>('modelNew');

  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Flights",
            style: ThemeTexts.textStyleTitle2
                .copyWith(fontWeight: FontWeight.normal, color: Colors.grey)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey.shade600,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {


                                                                  /// ///

                                         ///////////////////////////////////////////////////////

                                                                  /// ///

                modelMyFlightsDummy = ModelMyFlightsCreateTrip(
                  tripName: widget.tripName!,
                  noOfFlights: noOfFlights,
                  tripImage: tripImage,
                  modelMyFlightsUpcoming:
                  ModelMyFlightsUpcoming(
                    flightCode: "",
                    departureCity: "",
                    departureCityDate: "",
                    departureCityShortCode: "",
                    departureCityTime: "",
                    arrivalCity: "",
                    arrivalCityShortCode: "",
                    arrivalCityTime: "",
                    arrivalCityDate: "",
                    flightStatus: "",
                  ),
                );



                modelMyFlights == null
                    ? dataBox!.add(modelMyFlightsDummy!)
                    : dataBox!.add(modelMyFlights!);

                Navigator.pop(context);
                Navigator.pop(context);
                },
              icon: Icon(
                Icons.check,
                color: Colors.grey.shade600,
              ))
        ],
      ),
      body: ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
        valueListenable:
        Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming")
            .listenable(),
        builder: (context, box, _) {
          final items = box.values.toList().cast<ModelMyFlightsUpcoming>();

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
            return Flex(direction: Axis.vertical, children: [
              Expanded(
                child: ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                    return InkWell(

                      child: Card(
                        key: ValueKey(currentTask!.key),
                        child: Row(
                          children: [
                            Checkbox(
                              onChanged: (bool? checked) {
                                setState(() {

                                  isChecked[index] = checked!;
                                  isChecked[index] == true
                                      ? modelMyFlights =
                                      ModelMyFlightsCreateTrip(

                                        tripName: widget.tripName!,
                                        noOfFlights: "$count Flights",
                                        tripImage: tripImage,
                                        modelMyFlightsUpcoming:
                                          ModelMyFlightsUpcoming(
                                          flightCode: currentTask.flightCode,
                                          departureCity: currentTask.departureCity,
                                          departureCityDate: currentTask.departureCityDate,
                                          departureCityShortCode: currentTask.departureCityShortCode,
                                          departureCityTime: currentTask.departureCityTime,
                                          arrivalCity: currentTask.arrivalCity,
                                          arrivalCityShortCode: currentTask.arrivalCityShortCode,
                                          arrivalCityTime: currentTask.arrivalCityTime,
                                          arrivalCityDate: currentTask.arrivalCityDate,
                                          flightStatus: currentTask.flightStatus,

                                        ),
                                      )
                                      :
                                  modelMyFlightsDummy =
                                      ModelMyFlightsCreateTrip(
                                        tripName: widget.tripName!,
                                        noOfFlights: "$count Flights",
                                        tripImage: tripImage,
                                        modelMyFlightsUpcoming:
                                          ModelMyFlightsUpcoming(
                                          flightCode: "",
                                          departureCity: "",
                                          departureCityDate: "",
                                          departureCityShortCode: "",
                                          departureCityTime: "",
                                          arrivalCity: "",
                                          arrivalCityShortCode: "",
                                          arrivalCityTime: "",
                                          arrivalCityDate: "",
                                          flightStatus: '',
                                        ),
                                      );
                                  print(isChecked[index]);
                                },
                                );
                              },
                              value: isChecked[index],
                            ),
                            // IconButton(onPressed: (){
                            //   setState(() {
                            //     currentTask.isSelected =! currentTask.isSelected!;
                            //     if (currentTask.isSelected == true) {
                            //       selectedItems.add(
                            //         ModelMyFlightsUpcoming(
                            //               flightCode: currentTask.flightCode,
                            //               departureCity: currentTask.departureCity,
                            //               departureCityDate: currentTask.departureCityDate,
                            //               departureCityShortCode: currentTask.departureCityShortCode,
                            //               departureCityTime: currentTask.departureCityTime,
                            //               arrivalCity: currentTask.arrivalCity,
                            //               arrivalCityShortCode: currentTask.arrivalCityShortCode,
                            //               arrivalCityTime: currentTask.arrivalCityTime,
                            //               arrivalCityDate: currentTask.arrivalCityDate,
                            //               flightStatus: currentTask.flightStatus,
                            //
                            //             ),
                            //       );
                            //       print(selectedItems.length);
                            //       print(selectedItems.map((e) => e.flightCode));
                            //     }
                            //     else if (currentTask.isSelected == false) {
                            //       selectedItems.removeWhere((element) =>
                            //       element.flightCode == currentTask.flightCode);
                            //       print(selectedItems.length);
                            //       print(selectedItems.map((e) => e.flightCode));
                            //     }
                            //     else{
                            //       getSelectedItems();
                            //     }
                            //   });
                            // },
                            //     icon: currentTask.isSelected! ?
                            //     Icon(Icons.check_box, color: ColorsTheme.primaryColor,) :
                            //     Icon(Icons.check_box_outline_blank)
                            // ),
                            Spacer(),
                            SizedBox(
                              width: w * 0.84,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: ColorsTheme.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(currentTask.flightCode,
                                            style: ThemeTexts.textStyleTitle3
                                                .copyWith(color: Colors.white)),
                                        Text(currentTask.flightStatus!,
                                            style: ThemeTexts.textStyleTitle3
                                                .copyWith(color: Colors.white))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15),
                                    color: Colors.grey.shade200,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "🗓️ ${currentTask.departureCityDate}",
                                            style: ThemeTexts.textStyleTitle3.copyWith(
                                                color: Colors.black87)),
                                        Text(
                                            "🗓️ ${currentTask.arrivalCityDate}",
                                            style: ThemeTexts.textStyleTitle3.copyWith(
                                                color: Colors.black87)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        flightDetails(
                                          cityName: currentTask.departureCity,
                                          cityShortCode: currentTask.departureCityShortCode,
                                          cityTime: currentTask.departureCityTime,
                                          crossAlignment: CrossAxisAlignment.start,
                                        ),
                                        RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(
                                            Icons.flight,
                                            size: 50,
                                            color: Colors.grey,),
                                        ),
                                        flightDetails(
                                          cityName: currentTask.arrivalCity,
                                          cityShortCode: currentTask.arrivalCityShortCode,
                                          cityTime: currentTask.arrivalCityTime,
                                          crossAlignment: CrossAxisAlignment.end,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]);
          }
        },
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

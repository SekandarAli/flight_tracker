// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightCreateNewTrip extends StatefulWidget {
  MyFlightCreateNewTrip({Key? key, required this.tripName}) : super(key: key);

  String tripName;

  @override
  State<MyFlightCreateNewTrip> createState() => _MyFlightCreateNewTripState();
}

class _MyFlightCreateNewTripState extends State<MyFlightCreateNewTrip> {
  Box<ModelMyFlightsCreateTrip>? dataBox;
  ModelMyFlightsCreateTrip? modelMyFlights;
  ModelMyFlightsCreateTrip? modelMyFlightsDummy;

  String noOfFlights = '0 Flight';
  String tripImage = "Image";
  bool isSelected = true;
  List<bool> isChecked = List.generate(10, (index) => false);

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
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

                modelMyFlightsDummy =
                    ModelMyFlightsCreateTrip(
                      tripName: widget.tripName,
                      noOfFlights: noOfFlights,
                      tripImage: tripImage,
                      modelMyFlightsUpcoming: ModelMyFlightsUpcoming(
                        flightCode: "",
                        departureCity: "",
                        departureCityDate: "",
                        departureCityShortCode: "",
                        departureCityTime: "",
                        arrivalCity: "",
                        arrivalCityShortCode: "",
                        arrivalCityTime: "",
                        arrivalCityDate: "",
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

                    // ModelMyFlightsCreateTrip modelCreateTrip = box.getAt(index);
                    return InkWell(
                      // onTap: (){

                      // setState(() {
                      //   selectedContacts[index].isSelected =! selectedContacts![index].isSelected;
                      //   if (selectedContacts[index].isSelected == true) {
                      //     selectedContacts.add(ModelMyFlightsCreateTrip(
                      //
                      //       tripName: widget.tripName,
                      //           noOfFlights: noOfFlights,
                      //           tripImage: tripImage,
                      //           modelMyFlightsUpcoming: ModelMyFlightsUpcoming(
                      //
                      //             flightCode: currentTask!.flightCode,
                      //             departureCity: currentTask.departureCity,
                      //             departureCityDate: currentTask.departureCityDate,
                      //             departureCityShortCode: currentTask.departureCityShortCode,
                      //             departureCityTime: currentTask.departureCityTime,
                      //             arrivalCity: currentTask.arrivalCity,
                      //             arrivalCityShortCode: currentTask.arrivalCityShortCode,
                      //             arrivalCityTime: currentTask.arrivalCityTime,
                      //             arrivalCityDate: currentTask.arrivalCityDate,
                      //
                      //           )
                      //
                      //     ));
                      //   } else if (selectedContacts[index].isSelected == false) {
                      //     selectedContacts
                      //         .removeWhere((element) => element.tripName == selectedContacts[index].tripName);
                      //   }
                      // });},

                      ///hhhhhhhh
                      //   onTap: (){
                      //
                      //     setState((){
                      //       // modelMyFlights!.isSelected =! modelMyFlights!.isSelected;
                      //       // if(modelMyFlights!.isSelected == true) {
                      //
                      //
                      //      /// var list = [];
                      //      /// if(isSelected == true){
                      //      ///   list.add(modelMyFlights);
                      //      /// }
                      //      ///
                      //      /// else{
                      //      ///   list.removeWhere((element) => element.tripName == list[index].tripName);
                      //      /// }
                      //
                      //       isSelected =! isSelected;
                      //
                      //         modelMyFlights = ModelMyFlightsCreateTrip(
                      //         tripName: widget.tripName,
                      //         noOfFlights: noOfFlights,
                      //         tripImage: tripImage,
                      //         modelMyFlightsUpcoming: ModelMyFlightsUpcoming(
                      //           flightCode: currentTask.flightCode,
                      //           departureCity: currentTask.departureCity,
                      //           departureCityDate:
                      //               currentTask.departureCityDate,
                      //           departureCityShortCode:
                      //               currentTask.departureCityShortCode,
                      //           departureCityTime:
                      //               currentTask.departureCityTime,
                      //           arrivalCity: currentTask.arrivalCity,
                      //           arrivalCityShortCode:
                      //               currentTask.arrivalCityShortCode,
                      //           arrivalCityTime: currentTask.arrivalCityTime,
                      //           arrivalCityDate: currentTask.arrivalCityDate,
                      //         ),
                      //             // isSelected: modelMyFlights!.isSelected
                      //         );
                      // });
                      //
                      //
                      // },

                      child: Card(
                        child: Row(
                          children: [
                            Checkbox(
                              onChanged: (bool? checked) {
                                setState(() {

                                  isChecked[index] = checked!;

                                  isChecked[index] == true


                                      ? modelMyFlights =
                                      ModelMyFlightsCreateTrip(

                                        tripName: widget.tripName,
                                        noOfFlights: noOfFlights,
                                        tripImage: tripImage,
                                        modelMyFlightsUpcoming: ModelMyFlightsUpcoming(
                                          flightCode: currentTask!.flightCode,
                                          departureCity: currentTask.departureCity,
                                          departureCityDate: currentTask.departureCityDate,
                                          departureCityShortCode: currentTask.departureCityShortCode,
                                          departureCityTime: currentTask.departureCityTime,
                                          arrivalCity: currentTask.arrivalCity,
                                          arrivalCityShortCode: currentTask.arrivalCityShortCode,
                                          arrivalCityTime: currentTask.arrivalCityTime,
                                          arrivalCityDate: currentTask.arrivalCityDate,

                                        ),
                                      )
                                      :
                                  modelMyFlightsDummy =
                                      ModelMyFlightsCreateTrip(
                                        tripName: widget.tripName,
                                        noOfFlights: noOfFlights,
                                        tripImage: tripImage,
                                        modelMyFlightsUpcoming: ModelMyFlightsUpcoming(
                                          flightCode: "",
                                          departureCity: "",
                                          departureCityDate: "",
                                          departureCityShortCode: "",
                                          departureCityTime: "",
                                          arrivalCity: "",
                                          arrivalCityShortCode: "",
                                          arrivalCityTime: "",
                                          arrivalCityDate: "",
                                        ),
                                      );
                                  print(isChecked[index]);
                                },
                                );
                              },
                              value: isChecked[index],
                            ),
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
                                        Text(currentTask!.flightCode,
                                            style: ThemeTexts.textStyleTitle3
                                                .copyWith(color: Colors.white)),
                                        Text("Scheduled",
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
                                        Icon(Icons.flight_land_rounded,
                                            size: 50),
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

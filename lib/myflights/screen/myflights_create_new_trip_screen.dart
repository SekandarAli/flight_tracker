// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/myflights_model.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class AddMyFlightsScreen extends StatefulWidget {
  const AddMyFlightsScreen({Key? key}) : super(key: key);

  @override
  State<AddMyFlightsScreen> createState() => _AddMyFlightsScreenState();
}

class _AddMyFlightsScreenState extends State<AddMyFlightsScreen> {
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        title: Text("Add Flights", style: ThemeTexts.textStyleTitle2
            .copyWith(fontWeight: FontWeight.normal)),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyFlightsScreen()));
          }, icon: Icon(Icons.check))
        ],
      ),
      body:ValueListenableBuilder<Box<ModelMyFlights>>(
        valueListenable:
        Hive.box<ModelMyFlights>("modelMyFlights").listenable(),
        builder: (context, box, _) {
          final items = box.values.toList().cast<ModelMyFlights>();

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
                        bool value = false;
                        ModelMyFlights? currentTask = box.getAt(index);
                        return Card(
                          child: Row(
                            children: [
                              Checkbox(value: value, onChanged: (bool? value){
                                setState(() {
                                  value = value;
                                });
                              }),
                              // Icon(Icons.add),
                              Spacer(),
                              SizedBox(
                                width: w * 0.89,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(currentTask!.flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
                                          Text("Scheduled", style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white))
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
                                          Text("🗓️ ${currentTask.departureCityDate}",
                                              style: ThemeTexts.textStyleTitle3
                                                  .copyWith(
                                                  color: Colors.black87)),
                                          Text("🗓️ ${currentTask.arrivalCityDate}",
                                              style: ThemeTexts.textStyleTitle3
                                                  .copyWith(
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
                                              crossAlignment:
                                              CrossAxisAlignment.start),
                                          Icon(Icons.flight_land_rounded,
                                              size: 50),
                                          flightDetails(
                                              cityName: currentTask.arrivalCity,
                                              cityShortCode: currentTask.arrivalCityShortCode,
                                              cityTime: currentTask.arrivalCityTime,
                                              crossAlignment:
                                              CrossAxisAlignment.end),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),]
            );
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

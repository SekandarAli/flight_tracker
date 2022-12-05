// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../flight_detail/screen/flight_detail_screen.dart';

class MyFlightsUpcomingShowAllScreen extends StatefulWidget {
  const MyFlightsUpcomingShowAllScreen({Key? key}) : super(key: key);

  @override
  State<MyFlightsUpcomingShowAllScreen> createState() => _MyFlightsUpcomingShowAllScreenState();
}

class _MyFlightsUpcomingShowAllScreenState extends State<MyFlightsUpcomingShowAllScreen> {

  Box<ModelMyFlightsCreateTrip>? dataBox;
  Box<ModelMyFlightsUpcoming>? dataBoxUpcoming;
  ModelMyFlightsCreateTrip? modelMyFlights;
  bool isEdit = false;
  List<bool> isChecked = List.generate(10, (index) => true);


  List<ModelMyFlightsUpcoming> selectedItems = [];
  List<ModelMyFlightsUpcoming> getSelectedItems() => selectedItems;

  ModelMyFlightsUpcoming? currentTask;

  var items;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
    dataBoxUpcoming = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  }
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: isEdit == false ?
      AppBar(
        title: Text("MY FLIGHTS", style: ThemeTexts.textStyleTitle2
            .copyWith(fontWeight: FontWeight.normal)),
        actions: [
          TextButton(onPressed: (){
            setState(() {
              isEdit =! isEdit;
            });
          }, child: Text("EDIT",style: ThemeTexts.textStyleTitle3,))
        ],
      )
          :
      AppBar(
        backgroundColor: Colors.white,
        title: Text("MY FLIGHTS", style: ThemeTexts.textStyleTitle2
            .copyWith(fontWeight: FontWeight.normal,color: Colors.grey)),
        leading: IconButton(onPressed: (){
          setState(() {
            isEdit =! isEdit;
          });
        },
        icon: Icon(Icons.arrow_back,color: Colors.grey,),),
        actions: [
          IconButton(onPressed: (){
            // var task = items.values.where((_) => currentTask!.isSelected == true).first;
            // task.delete();
            openDialogue();
            setState(() {
              print(selectedItems);
              // selectedItems.removeWhere((element) =>  element.isSelected == true);
              // dataBoxUpcoming!.deleteAll(selectedItems);
            });

          }, icon: Icon(Icons.delete,color: Colors.grey))
        ],
      ),
      body: isEdit == false ? ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
        valueListenable:
        Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming").listenable(),
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
                      size: w * 0.3,
                      color: Colors.grey,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No Flights Found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          } else {
            return  ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
              valueListenable:
              Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming").listenable(),
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
                  return Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return FlightDetailScreen(flight_iata: currentTask.flightIata,);
                                  }));
                                },
                                child: Dismissible(
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content:
                                        Text('Flight Removed Successfully'),
                                            duration: Duration(milliseconds: 700),));
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
                                              Text(currentTask!.flightCode!, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
                                              Text(currentTask.flightStatus!, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(15),
                                          color: Colors.grey.shade100,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [

                                              // Text("🗓️ ${currentTask.departureCityDate}",
                                              //     style: ThemeTexts.textStyleTitle3
                                              //         .copyWith(
                                              //         color: Colors.black87)),
                                              Text("🗓️ ${currentTask.arrivalCityDate}",
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
                                                  cityName: currentTask.departureCity!,
                                                  cityShortCode: currentTask.departureCityShortCode!,
                                                  cityTime: currentTask.departureCityTime!,
                                                  crossAlignment:
                                                  CrossAxisAlignment.start),

                                              RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                  Icons.flight,
                                                  size: 50,
                                                  color: Colors.grey,),
                                              ),

                                              flightDetails(
                                                  cityName: currentTask.arrivalCity!,
                                                  cityShortCode: currentTask.arrivalCityShortCode!,
                                                  cityTime: currentTask.arrivalCityTime!,
                                                  crossAlignment:
                                                  CrossAxisAlignment.end),

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),]
                  );
                }
              },
            );
          }
        },
      ) :
      ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
        valueListenable:
        Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming")
            .listenable(),
        builder: (context, box, _) {
           items = box.values.toList().cast<ModelMyFlightsUpcoming>();

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
                     ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                    return InkWell(
                      onTap: (){
                        setState(() {
                          currentTask.isSelected =! currentTask.isSelected!;
                          if (currentTask.isSelected == true) {
                            selectedItems.add(
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
                                isSelected: currentTask.isSelected,
                              ),
                            );
                            print(currentTask.isSelected);
                          }
                          else {
                            selectedItems.removeWhere((element) =>
                            element.flightCode == currentTask.flightCode);
                          }
                        });
                      },
                      child: Card(
                        key: ValueKey(currentTask!.key),
                        child: Row(
                          children: [
                            currentTask.isSelected == true ?
                            Icon(Icons.check_box, color: ColorsTheme.primaryColor,) :
                            Icon(Icons.check_box_outline_blank),
                            Spacer(),
                            SizedBox(
                              width: w * 0.9,
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
                                        Text(currentTask.flightCode!,
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
                                      MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //     "🗓️ ${currentTask.departureCityDate}",
                                        //     style: ThemeTexts.textStyleTitle3.copyWith(
                                        //         color: Colors.black87)),
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
                                          cityName: currentTask.departureCity!,
                                          cityShortCode: currentTask.departureCityShortCode!,
                                          cityTime: currentTask.departureCityTime!,
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
                                          cityName: currentTask.arrivalCity!,
                                          cityShortCode: currentTask.arrivalCityShortCode!,
                                          cityTime: currentTask.arrivalCityTime!,
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

  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure to you want to Delete All the Items?'),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    // dataBoxUpcoming!.clear();
                    dataBoxUpcoming!.deleteAt(0);
                    isEdit =! isEdit;
                    Navigator.of(context).pop();
                  });
                },
                child: Text('OK')),
            TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    isEdit =! isEdit;
                  });
                },
                child: Text('CANCEL')),
          ],
        );
      });
}

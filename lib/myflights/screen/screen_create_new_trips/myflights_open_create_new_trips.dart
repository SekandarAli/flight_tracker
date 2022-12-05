// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/screen/screen_create_new_trips/myflights_create_new_trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../flight_detail/screen/flight_detail_screen.dart';

class MyFlightsOpenCreateNewTrips extends StatefulWidget {
  MyFlightsOpenCreateNewTrips({Key? key,required this.noOfFlights,required this.tripName,required this.currentTask}) : super(key: key);

  int noOfFlights;
  String tripName;
  var currentTask;

  @override
  State<MyFlightsOpenCreateNewTrips> createState() => _MyFlightsOpenCreateNewTripsState();
}

class _MyFlightsOpenCreateNewTripsState extends State<MyFlightsOpenCreateNewTrips> {

  TextEditingController? editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      // child: IconButton(onPressed: (){
                      //
                      // }, icon: Icon(Icons.more_vert,color: Colors.white,))
                      child: PopupMenuButton(
                        // color: Colors.white,
                        icon: Icon(Icons.more_vert, color: Colors.white,),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.drive_file_rename_outline),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Rename Trip")
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.flight),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Add Flight")
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Delete Trip")
                              ],
                            ),
                          ),
                        ],
                        offset: Offset(0, 40),
                        elevation: 2,
                        onSelected: (value) async {
                          if (value == 1)  {

                            var dialogueText = await ReusingWidgets().dialogueBoxSimple(
                                context: context,
                                titleText: "Edit Trip Name",
                                hintText: "Enter New Trip Name",
                                textEditingController: editingController!);
                            if (dialogueText != null) {
                              setState(() {
                                widget.currentTask.tripName = editingController!.text.toString();
                                widget.tripName = editingController!.text.toString();
                                widget.currentTask.save();
                              });
                            }
                            else{
                              // dialogueText = "Enter Flight Code";
                            }
                          }
                          else if (value == 2) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFlightCreateNewTrip()));
                          }
                          else if (value == 3) {
                            deleteDialogue(currentTask: widget.currentTask);
                          }
                        },
                      ),
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
                        Text("${widget.noOfFlights} Flights"),
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
                          return Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: widget.currentTask.modelMyFlightsUpcoming!.length,
                                    itemBuilder: (context, index) {
                                      return
                                        widget.currentTask.modelMyFlightsUpcoming[index].flightCode!.isNotEmpty ?
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return FlightDetailScreen(
                                                  flight_iata: widget.currentTask.modelMyFlightsUpcoming[index].flightCode!);
                                            }));
                                          },
                                          // child: Dismissible(
                                            // key: Key(
                                            //     UniqueKey().toString()),
                                            // background: Container(
                                            //   margin: EdgeInsets.all(5),
                                            //   padding: EdgeInsets.all(15),
                                            //   color: ColorsTheme.dismissibleColor,
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //     children: [
                                            //       Icon(Icons.delete,color: Colors.white,),
                                            //       Icon(Icons.delete,color: Colors.white,),
                                            //     ],
                                            //   ),
                                            // ),
                                            // onDismissed: (direction){
                                            //   setState(() {
                                            //     print("aaa${ widget.currentTask.modelMyFlightsUpcoming![index].flightCode}");
                                            //   });
                                            //   ScaffoldMessenger.of(context).showSnackBar(
                                            //       SnackBar(
                                            //           content: Text('Flight Removed Successfully'),
                                            //           duration: Duration(milliseconds: 700)));
                                            // },
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(15),
                                                    color: ColorsTheme.primaryColor,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(widget.currentTask.modelMyFlightsUpcoming![index].flightCode!, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white)),
                                                        Text(widget.currentTask.modelMyFlightsUpcoming![index].flightStatus!, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white))
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

                                                        // Text("🗓️ ${currentTask.modelMyFlightsUpcoming!.departureCityDate}",
                                                        //     style: ThemeTexts.textStyleTitle3
                                                        //         .copyWith(
                                                        //         color: Colors.black87)),
                                                        Text("🗓️ ${widget.currentTask.modelMyFlightsUpcoming![index].arrivalCityDate!}",
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
                                                            cityName: widget.currentTask.modelMyFlightsUpcoming![index].departureCity!,
                                                            cityShortCode: widget.currentTask.modelMyFlightsUpcoming![index].departureCityShortCode!,
                                                            cityTime: widget.currentTask.modelMyFlightsUpcoming![index].departureCityTime!,
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
                                                            cityName: widget.currentTask.modelMyFlightsUpcoming![index].arrivalCity!,
                                                            cityShortCode: widget.currentTask.modelMyFlightsUpcoming![index].arrivalCityShortCode!,
                                                            cityTime: widget.currentTask.modelMyFlightsUpcoming![index].arrivalCityTime!,
                                                            crossAlignment: CrossAxisAlignment.end),

                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        // )
                                            : Container();
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

  Future<String?> deleteDialogue({required var currentTask}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to Delete this Trip?'),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    currentTask.delete();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                child: Text('OK')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('CANCEL')),
          ],
        );
      });

}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/flight_detail/screen/flight_detail_airport_airline.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/myflights/screen/screen_create_new_trips/myflights_create_new_trip_screen.dart';
import 'package:flight_tracker/myflights/screen/screen_create_new_trips/myflights_open_create_new_trips.dart';
import 'package:flight_tracker/myflights/screen/screen_my_upcoming__flights/myflights_upcoming_show_all.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyFlightsScreen extends StatefulWidget {
  const MyFlightsScreen({Key? key}) : super(key: key);

  @override
  State<MyFlightsScreen> createState() => _MyFlightsScreenState();
}

class _MyFlightsScreenState extends State<MyFlightsScreen> {
  TextEditingController createTripController = TextEditingController();

  TextEditingController? editingController = TextEditingController();

  List<ModelMyFlightsUpcoming> finalItemsList = [];

  ModelMyFlightsCreateTrip? task;
  List<ModelMyFlightsUpcoming>? modelItemsList;


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsTheme.myFlightsbg,
      appBar: AppBar(
        title: Text(
          "MY FLIGHTS",
          style: ThemeTexts.textStyleTitle2
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              /// CREATE NEW TRIP STARTS

              myUpComingFlightsText(text: "My Trips", icon: Icons.kitchen),
              Row(
                children: [
                  createTrip(
                      width: w,
                      onTap: () {
                        // openDialogue();
                        showDilougee();
                      }),
                  Container(
                    color: ColorsTheme.myFlightsbg,
                    height: w * 0.37,
                    width: w * 0.58,
                    child: ValueListenableBuilder<Box<ModelMyFlightsCreateTrip>>(
                      valueListenable:
                      Hive.box<ModelMyFlightsCreateTrip>("modelMyFlightsTrip").listenable(),
                      builder: (context, box, _) {
                        final items = box.values.toList().cast<ModelMyFlightsCreateTrip>();

                        if (items.isEmpty) {
                          return Container();
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              ModelMyFlightsCreateTrip? currentTask = box.getAt(index);
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      print(currentTask.tripName);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return MyFlightsOpenCreateNewTrips(
                                          noOfFlights: currentTask.modelMyFlightsUpcoming.length,
                                          tripName: currentTask.tripName,
                                          currentTask: currentTask,
                                        );
                                      }));
                                    },
                                    child: SizedBox(
                                      height: w * 0.4,
                                      width: w * 0.4,
                                      child: Card(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/airline.png",
                                              width: w * 0.4,
                                              height: w * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              currentTask!.tripName,
                                              style: ThemeTexts.textStyleTitle3.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "${currentTask.modelMyFlightsUpcoming!.length} Flights",
                                              // "Flights",
                                              style: ThemeTexts.textStyleTitle3.copyWith(
                                                  color: Colors.grey,
                                                  letterSpacing: 0),
                                            ),

                                            // Container(
                                            //   height: 10,
                                            //   child: ListView.builder(
                                            //     scrollDirection: Axis.horizontal,
                                            //       itemCount: currentTask.modelMyFlightsUpcoming!.length,
                                            //       itemBuilder: (context, index) {
                                            //         return Text(
                                            //           "${currentTask.modelMyFlightsUpcoming![index].flightCode!}\t\t\t",
                                            //         );
                                            //       }),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(),

                ],
              ),

              /// CREATE NEW TRIP END

              /// My Upcoming Flights Starts

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myUpComingFlightsText(text: "My Upcoming Flights", icon: Icons.flight_outlined),
                  myUpComingFlightsText(text: "SHOW ALL",color: ColorsTheme.primaryColor,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MyFlightsUpcomingShowAllScreen();
                      }));
                    },),
                ],
              ),

              SizedBox(
                height: h * 0.7,
                width: w,
                child: ValueListenableBuilder<Box<ModelMyFlightsUpcoming>>(
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
                      return Flex(
                          direction: Axis.vertical,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: box.values.length,
                                itemBuilder: (context, index) {
                                  ModelMyFlightsUpcoming? currentTask = box.getAt(index);
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return FlightDetailAirportAirline(flight_iata: currentTask.flightIata,);
                                      }));
                                    },
                                    child: Dismissible(
                                      key: Key(UniqueKey().toString()),
                                      background: Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(15),
                                        color: ColorsTheme.dismissibleColor,
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
                                            SnackBar(content: Text('Flight Removed Successfully'),
                                                duration: Duration(milliseconds: 700)));
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
                                                  // Text("🗓️ ${currentTask.departureCityDate}".substring(0,23),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myUpComingFlightsText({
    required String text,
    IconData? icon,
    Function()? onTap,
    Color? color
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){onTap!();},
        child: Row(
          children: [
            Icon(icon),
            Text(
              text,
              style: ThemeTexts.textStyleValueBlack.copyWith(letterSpacing: 1,color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTrip({required double width, required Function() onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(4),
        height: width * 0.37,
        width: width * 0.37,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outlined,
                color: ColorsTheme.primaryColor,
                size: width * 0.12,
              ),
              SizedBox(height: 10),
              Text(
                "Create New Trip",
                style: ThemeTexts.textStyleTitle3.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Trip'),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              children: [
                textFormFields(
                    width: MediaQuery.of(context).size.width / 2,
                    hintText: "Enter Trip Name",
                    textController: createTripController),
                finalItemsList.isEmpty
                    ? Container(height: 0,color: Colors.green,)
                    : Container(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  height: MediaQuery.of(context).size.height / 2,
                     child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: finalItemsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              finalItemsList[index].flightCode!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {},
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async{
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return MyFlightCreateNewTrip(tripName: createTripController.text.toString());
                  // }));

                  Map result = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MyFlightCreateNewTrip(tripName: createTripController.text.toString())));

                  if (result != null && result.containsKey('itemList')) {
                    setState(() {
                      finalItemsList = result['itemList'];
                      print("final: ${finalItemsList}");
                    });
                  }
                  else{
                    return null;
                  }

                },
                child: Text('ADD TRIP DATA')),
            TextButton(
                onPressed: () async{
                  // Navigator.of(context).pop();
                  var newTask = ModelMyFlightsCreateTrip(
                      tripName: createTripController.text,
                      noOfFlights: '0',
                      tripImage: '',
                      modelMyFlightsUpcoming: finalItemsList
                  );

                  Box<ModelMyFlightsCreateTrip> taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');

                  if (task != null) {
                    task!.tripName = newTask.tripName;
                    modelItemsList = finalItemsList;
                    task!.save();
                    Navigator.pop(context);
                  } else {
                    await taskBox.add(newTask);
                    Navigator.pop(context);
                  }
                },
                child: Text('SAVE')),
          ],
        );
      });


  showDilougee(){
    return  showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              insetPadding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return SizedBox(
                    height: double.infinity,
                    width: double.maxFinite,
                    child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                  Text(
                                    "CREATE TRIP",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var newTask = ModelMyFlightsCreateTrip(
                                          tripName: createTripController.text,
                                          noOfFlights: '0',
                                          tripImage: '',
                                          modelMyFlightsUpcoming: finalItemsList
                                      );

                                      Box<ModelMyFlightsCreateTrip> taskBox = Hive.box<ModelMyFlightsCreateTrip>('modelMyFlightsTrip');

                                      if (task != null) {
                                        task!.tripName = newTask.tripName;
                                        modelItemsList = finalItemsList;
                                        task!.save();
                                        Navigator.pop(context);
                                        modelItemsList!.clear();
                                        finalItemsList.clear();
                                      } else {
                                        await taskBox.add(newTask);
                                        Navigator.pop(context);
                                        modelItemsList!.clear();
                                        finalItemsList.clear();
                                      }
                                      // await taskBox.add(newTask);
                                      // Navigator.pop(context);

                                      // task!.tripName = "";

                                    },
                                    child: Text(
                                        "SAVE",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          textFormFields(
                              width: MediaQuery.of(context).size.width / 1.2,
                              hintText: "Enter Trip Name",
                              textController: createTripController),
                          ElevatedButton(onPressed: ()async{
                            Map result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MyFlightCreateNewTrip(tripName: createTripController.text.toString())));

                            if (result.containsKey('itemList')) {
                              setState(() {
                                finalItemsList = result['itemList'];
                                print("final: $finalItemsList");
                              });
                            }
                            else{
                              return null;
                            }
                          }, child: Text(
                            "ADD TRIPS",
                          ),),
                          finalItemsList.isEmpty
                              ? Container()
                              : Container(
                                    padding: EdgeInsets.symmetric(horizontal: 9),
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: finalItemsList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        finalItemsList[index].flightCode!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                  );
                },
              ),
            ));
  }

  Widget textFormFields({
    required double width,
    required String hintText,
    required TextEditingController textController,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: textController,
        style: TextStyle(fontSize: 12),
        // keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.grey,
            ),
          ),
        ),
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

  Future<String?> openDialogueNew({required var tripName}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Trip Name'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: TextFormField(
                  controller: editingController,
                  maxLength: 10,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "Enter Trip Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  setState(() {
                    print("tripname $tripName");
                    tripName = editingController!.text.toString();
                    print("tripname $tripName");
                    Navigator.of(context).pop(editingController!.text.toString());
                    // Navigator.of(context).pop();
                  });

                },
                    child: Text('DONE')),
              ],
            ),
          ],
        );
      });

}

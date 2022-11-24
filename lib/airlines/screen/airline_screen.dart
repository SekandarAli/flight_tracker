// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:flight_tracker/airlines/screen/airline_screen_detail.dart';
import 'package:flight_tracker/airlines/services/services_airlines.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';

class AirlineScreen extends StatefulWidget {

  AirlineScreen({super.key});

  @override
  State<AirlineScreen> createState() => _AirlineScreenState();
}

class _AirlineScreenState extends State<AirlineScreen> {

  String? airlineName = "Lahore";
  String? countryShortName = "PK";
  TextEditingController searchAirlineController = TextEditingController();
  Future<ModelAirlines>? futureList;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureList = ServicesAirlines().GetAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.primaryColor,
      body: SafeArea(
        child: Container(
          color: ColorsTheme.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorsTheme.primaryColor,
                padding: EdgeInsets.all(12),
                child: TextFormField(
                  controller: searchAirlineController,
                  enableInteractiveSelection: false,
                  style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  onChanged: (String value) {
                    print(value);
                    setState(() {});
                  },
                  decoration: ReusingWidgets.SearchTextFormField(
                      hintText: "Search for an Airline",
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: futureList,
                  builder: (context,snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.response!.isNotEmpty) {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  padding: EdgeInsets.all(5),
                                  itemCount: snapshot.data!.response!.length,
                                  itemBuilder: (context, index) {
                                    String? airlineName = snapshot.data!.response![index].name ?? "Unknown";
                                    String? countryShortName = snapshot.data!.response![index].iataCode ?? "Unknown";
                                    String? airportImage;
                                    String? iataValue = snapshot.data!.response![index].icaoCode ?? "Unknown";

                                    return airlineName.toLowerCase().contains(searchAirlineController.text) ?
                                    InkWell(
                                        onTap: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return AirlineScreenDetails(airlineName: airlineName,iataValue: iataValue,);
                                          }));
                                        },
                                        child: ListTile(
                                          title: Text(airlineName,style: ThemeTexts.textStyleValueBlack.copyWith(fontWeight: FontWeight.bold),),
                                          subtitle: Text(countryShortName,style: ThemeTexts.textStyleValueBlack2),
                                          trailing: FlutterLogo(
                                            size: 40,
                                            textColor: Colors.blue,
                                            style: FlutterLogoStyle.stacked,
                                          ), //F
                                        )) : Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "error 1${snapshot.error}",
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "error 2${snapshot.error}",
                        ),
                      );
                    } else {
                      return Center(child: FunctionProgressIndicator());
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
}

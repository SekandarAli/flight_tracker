// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:flight_tracker/airlines/screen/airline_screen_detail.dart';
import 'package:flight_tracker/airlines/services/services_airlines.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class AirlineScreen extends StatefulWidget {

  AirlineScreen({super.key});

  @override
  State<AirlineScreen> createState() => _AirlineScreenState();
}

class _AirlineScreenState extends State<AirlineScreen> {

  String? airlineName = "Lahore";
  String? countryShortName = "PK";
  var airlineImage;
  final searchAirportController = TextEditingController();
  Future<ModelAirlines>? future_list;

  @override
  void initState() {
    super.initState();
    setState(() {
      future_list = ServicesAirlines().GetAllPosts();
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
                  // focusNode: focusNode,
                  controller: searchAirportController,
                  enableInteractiveSelection: false,
                  style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  onChanged: (String value) {
                    // autoCompleteSearch(value);
                    print(value);
                  },
                  decoration: ReusingWidgets.SearchTextFormField(
                      context: context,
                      controller: searchAirportController,
                      hintText: "Search for an Airline",
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: future_list,
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
                                    return InkWell(
                                        onTap: () async {
                                          // Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return AirlineScreenDetails();
                                          }));
                                        },
                                        child: ListTile(
                                          title: Text("${snapshot.data!.response![index].name}",style: ThemeTexts.textStyleValueBlack,),
                                          subtitle: Text("${snapshot.data!.request!.client!.geo!.countryCode}",style: ThemeTexts.textStyleValueBlack2),
                                          trailing: FlutterLogo(
                                            size: 40,
                                            textColor: Colors.blue,
                                            style: FlutterLogoStyle.stacked,
                                          ), //F
                                        ));
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
                      return Center(child: CircularProgressIndicator(
                        backgroundColor: ColorsTheme.primaryColor,
                        valueColor: AlwaysStoppedAnimation(Colors.grey),
                        strokeWidth: 10,
                      ));
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

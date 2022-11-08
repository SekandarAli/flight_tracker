// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/airports/model/model_airport.dart';
import 'package:flight_tracker/airports/screen/airport_screen_detail.dart';
import 'package:flight_tracker/airports/services/services_airports.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class AirportsScreen extends StatefulWidget {
  AirportsScreen({super.key});

  @override
  State<AirportsScreen> createState() => _AirportsScreenState();
}

class _AirportsScreenState extends State<AirportsScreen> {
  bool isSearching = true;
  final searchAirportController = TextEditingController();
  String? placeId;
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
  DetailsResult? detailsResult;

  void autoCompleteSearch(String value) async {
    var result = await googlePlace!.autocomplete.get(value);
    print("Hello $result");

    if (result != null && result.predictions != null && mounted) {
      print("Hello ${result.predictions}");
      setState(() {
        predictions = result.predictions!;
      });
    }
  }


  Future<ModelAirport>? future_list;

  @override
  void initState() {
    super.initState();
    setState(() {
      future_list = ServicesAirports().GetAllPosts();
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
                  style:
                      ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  onChanged: (String value) {
                    // autoCompleteSearch(value);
                    print(value);
                  },
                  decoration: ReusingWidgets.SearchTextFormField(
                    context: context,
                    controller: searchAirportController,
                    hintText: "Search for an Airport",
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
                                      String? cityName = snapshot.data!.request!.client!.geo!.city;
                                      String? cityShortName = "LHR";
                                      String? countryShortName = snapshot.data!.request!.client!.geo!.countryCode;
                                      String? airportName = snapshot.data!.response![index].name;
                                      return InkWell(
                                          onTap: () async {
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return AirportScreenDetail(airportName: airportName!);
                                            }));
                                          },
                                          child: ListTile(
                                            title: Text(
                                              "$cityName,"
                                                  " $countryShortName",
                                              style: ThemeTexts.textStyleValueBlack,
                                            ),
                                            subtitle: Text("$cityShortName -  $airportName",
                                                style: ThemeTexts.textStyleValueBlack2),
                                            trailing: FlutterLogo(
                                              size: 30,
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

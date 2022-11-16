// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/airports/services/services_airports.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../airports/model/model_airport.dart';

class SearchTabArrivalDepartureAirport extends StatefulWidget {
  SearchTabArrivalDepartureAirport({super.key});

  @override
  State<SearchTabArrivalDepartureAirport> createState() => _SearchTabArrivalDepartureAirportState();
}

class _SearchTabArrivalDepartureAirportState extends State<SearchTabArrivalDepartureAirport> {

  TextEditingController searchAirportController = TextEditingController();
  Future<ModelAirport>? futureList;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureList = ServicesAirports().GetAllPosts();
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
                  controller: searchAirportController,
                  enableInteractiveSelection: false,
                  style:
                  ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  onChanged: (String value) {
                    setState(() {
                      // searchAirportController.text = value.toLowerCase();
                    });
                  },
                  decoration: ReusingWidgets.SearchTextFormField(
                    hintText: "Search for an Airport",
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: futureList,
                  builder: (context,snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data!.isNotEmpty) {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  padding: EdgeInsets.all(5),
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {

                                    // String? cityName = snapshot.data![index].countryName ?? "Unknown";
                                    // String? cityShortName = snapshot.data![index].cityIataCode;
                                    // String? countryShortName = snapshot.data![index].countryIso2;
                                    // String? airportName = snapshot.data![index].airportName;

                                    String? cityName = snapshot.data!.data![index].countryName ?? "Unknown";
                                    String? cityShortName = snapshot.data!.data![index].cityIataCode;
                                    String? countryShortName = snapshot.data!.data![index].countryIso2;
                                    String? airportName = snapshot.data!.data![index].airportName;

                                    return
                                      cityName.toLowerCase().contains(searchAirportController.text) ?
                                      InkWell(
                                          onTap: () async {
                                            Navigator.pop(context,[airportName]);
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
                      return Center(
                          child: FunctionProgressIndicator()
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

}

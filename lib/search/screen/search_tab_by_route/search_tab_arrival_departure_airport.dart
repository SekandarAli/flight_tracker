// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flight_tracker/airports/services/services_airports.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../airports/model/model_airport.dart';

class SearchTabArrivalDepartureAirport extends StatefulWidget {
  SearchTabArrivalDepartureAirport({super.key});

  @override
  State<SearchTabArrivalDepartureAirport> createState() => _SearchTabArrivalDepartureAirportState();
}

class _SearchTabArrivalDepartureAirportState extends State<SearchTabArrivalDepartureAirport> {

  TextEditingController searchAirportController = TextEditingController();
  List _items = [];


  @override
  void initState() {
    super.initState();
    setState(() {
      readJson();
    });
  }


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/airport.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["response"];
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
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: _items.length,
                          itemBuilder: (context, index) {

                            String cityShortName = _items[index]["iata_code"]  ?? "---";
                            // String? cityShortName = snapshot.data!.response![index].name  ?? "Unknown";
                            String countryShortName = _items[index]["country_code"] ?? "---";
                            String airportName = _items[index]["name"] ?? "---";

                            return
                              cityShortName.toLowerCase().contains(searchAirportController.text) ||
                                  airportName.toLowerCase().contains(searchAirportController.text) ?
                              InkWell(
                                  onTap: () async {
                                    Navigator.pop(context,[airportName,cityShortName]);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      "$cityShortName,"
                                          " $countryShortName",
                                      style: ThemeTexts.textStyleValueBlack,
                                    ),
                                    // subtitle: Text("$cityShortName -  $airportName",
                                    subtitle: Text(airportName,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

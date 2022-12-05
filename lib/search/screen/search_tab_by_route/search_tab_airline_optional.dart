// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:flight_tracker/airlines/services/services_airlines.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchTabAirlineOptional extends StatefulWidget {
  SearchTabAirlineOptional({super.key});

  @override
  State<SearchTabAirlineOptional> createState() => _SearchTabAirlineOptionalState();
}

class _SearchTabAirlineOptionalState extends State<SearchTabAirlineOptional> {

  TextEditingController searchAirlineController = TextEditingController();
  List _items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      readJson();
    });
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/airline.json');
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
                  controller: searchAirlineController,
                  enableInteractiveSelection: false,
                  style:
                  ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  onChanged: (String value) {
                    setState(() {
                    });
                  },
                  decoration: ReusingWidgets.SearchTextFormField(
                    hintText: "Search for an Airline",
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

                            String? airlineName = _items[index]["name"]  ?? "Unknown";
                            String? countryShortName = _items[index]["iata_code"]  ?? "Unknown";
                            String? airportImage;
                            String? iataValue = _items[index]["icao_code"]  ?? "Unknown";

                            return
                              airlineName!.toLowerCase().contains(searchAirlineController.text)
                                  || countryShortName!.toLowerCase().contains(searchAirlineController.text) ?
                              InkWell(
                                  onTap: () async {
                                    Navigator.pop(context,[airlineName,countryShortName]);
                                  },
                                  child: ListTile(
                                    title: Text(airlineName,style: ThemeTexts.textStyleValueBlack,),
                                    subtitle: Text(countryShortName!,style: ThemeTexts.textStyleValueBlack2),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

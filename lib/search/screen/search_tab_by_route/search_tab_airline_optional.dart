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
  List items = [];

  List rows = [];
  String query = '';
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
      items = data["response"];
    });
  }

  void setResults(String query) {
    rows = items
        .where((elem) => elem['icao_code'].toString().toLowerCase().contains(query.toLowerCase()) ||
        elem['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
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
              ReusingWidgets.SearchTextFormField(
                hintText: "Search for an Airline",
                textEditingController: searchAirlineController,
                onChange: (v) {
                  setState(() {
                    query = v;
                    setResults(query);
                  });
                },
                  onTapClear: (){
                    setState(() {
                      query = "";
                      searchAirlineController.clear();
                    });
                  }
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: ColorsTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All Airlines",
                          style: ThemeTexts.textStyleTitle1
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: ColorsTheme.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Flexible(
                                      child: query.isEmpty ?
                                      ListView.builder(
                                        padding: EdgeInsets.all(5),
                                        shrinkWrap: true,
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {

                                          String? airlineName = items[index]["name"]  ?? "Unknown";
                                          String? countryShortName = items[index]["iata_code"]  ?? "Unknown";
                                          String? icaoCode = items[index]["icao_code"]  ?? "Unknown";

                                          return
                                            InkWell(
                                                onTap: () async {
                                                  Navigator.pop(context,[airlineName,countryShortName,icaoCode]);
                                                },
                                                child: ListTile(
                                                  title: Text(airlineName!,style: ThemeTexts.textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                                                  subtitle: Text(countryShortName!,style: ThemeTexts.textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),
                                                ));
                                        },
                                      )
                                          :
                                      ListView.builder(
                                        padding: EdgeInsets.all(5),
                                        shrinkWrap: true,
                                        itemCount: rows.length,
                                        itemBuilder: (context, index) {

                                          String? airlineName = rows[index]["name"]  ?? "Unknown";
                                          String? countryShortName = rows[index]["iata_code"]  ?? "Unknown";
                                          String? icaoCode = rows[index]["icao_code"]  ?? "Unknown";

                                          return
                                            InkWell(
                                                onTap: () async {
                                                  Navigator.pop(context,[airlineName,countryShortName,icaoCode]);
                                                },
                                                child: ListTile(
                                                  title: Text(airlineName!,style: ThemeTexts.textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                                                  subtitle: Text(countryShortName!,style: ThemeTexts.textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),
                                                ));
                                        },
                                      )
                                  ),

                                ],
                              ),
                            )),
                      ],
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }

}

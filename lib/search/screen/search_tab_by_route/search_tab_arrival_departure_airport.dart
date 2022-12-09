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



  void setResults(String query) {
    rows = items
        .where((elem) => elem['iata_code'].toString().toLowerCase().contains(query.toLowerCase()) ||
        elem['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
  }


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/airport.json');
    final data = await json.decode(response);
    setState(() {
      items = data["response"];
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
              ReusingWidgets.SearchTextFormField(
                hintText: "Search for an Airport",
                textEditingController: searchAirportController,
                onChange: (v) {
                  setState(() {
                    query = v;
                    setResults(query);
                  });
                },
                  onTapClear: (){
                    setState(() {
                      query = "";
                      searchAirportController.clear();
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
                          "All Airports",
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
                                        String cityName = items[index]["iata_code"] ?? "---";
                                        String countryShortName = items[index]["country_code"] ?? "---";
                                        String airportName = items[index]["name"] ?? "---";
                                        String iataValue = items[index]["iata_code"] ?? "---";

                                        return
                                          InkWell(
                                              onTap: () async {
                                                Navigator.pop(context,[airportName,countryShortName,iataValue]);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  "$cityName,"" $countryShortName",
                                                  style: ThemeTexts
                                                      .textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle: Text(airportName,
                                                    style: ThemeTexts
                                                        .textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),
                                              ));
                                        // : Container();
                                      },
                                    )
                                        :
                                    ListView.builder(
                                      padding: EdgeInsets.all(5),
                                      shrinkWrap: true,
                                      itemCount: rows.length,
                                      itemBuilder: (context, index) {
                                        String cityName = rows[index]["iata_code"] ?? "---";
                                        String countryShortName = rows[index]["country_code"] ?? "---";
                                        String airportName = rows[index]["name"] ?? "---";
                                        String iataCode = rows[index]["iata_code"] ?? "---";

                                        return
                                          InkWell(
                                              onTap: () async {
                                                Navigator.pop(context,[airportName,countryShortName,iataCode]);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  "$cityName,"" $countryShortName",
                                                  style: ThemeTexts
                                                      .textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle: Text(airportName,
                                                    style: ThemeTexts
                                                        .textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),
                                              ));
                                        // : Container();
                                      },
                                    ),
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

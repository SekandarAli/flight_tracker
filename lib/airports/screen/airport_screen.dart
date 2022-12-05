// ignore_for_file: prefer_const_constructorsimport 'dart:async';import 'dart:convert';import 'package:flight_tracker/airports/screen/airport_screen_detail.dart';import 'package:flight_tracker/app_theme/color.dart';import 'package:flight_tracker/app_theme/reusing_widgets.dart';import 'package:flight_tracker/app_theme/theme_texts.dart';import 'package:flutter/material.dart';import 'package:flutter/services.dart';class AirportsScreen extends StatefulWidget {  AirportsScreen({super.key});  @override  State<AirportsScreen> createState() => _AirportsScreenState();}class _AirportsScreenState extends State<AirportsScreen> {  TextEditingController searchAirportController = TextEditingController();  List items = [];  List FilteredSearch = [];  @override  void initState() {    super.initState();    setState(() {      readJson();      FilteredSearch = items;    });  }  Future<void> readJson() async {    final String response = await rootBundle.loadString('assets/json/airport.json');    final data = await json.decode(response);    setState(() {      items = data["response"];    });  }  void filterSearch(){    setState((){      FilteredSearch = items.where((e)=>e.toLowerCase().contains(searchAirportController.text.toLowerCase())).toList();    });  }  @override  Widget build(BuildContext context) {    return Scaffold(      backgroundColor: ColorsTheme.primaryColor,      body: SafeArea(        child: Container(          color: ColorsTheme.white,          child: Column(            crossAxisAlignment: CrossAxisAlignment.start,            children: [              Container(                color: ColorsTheme.primaryColor,                padding: EdgeInsets.all(12),                child: TextFormField(                  controller: searchAirportController,                  enableInteractiveSelection: false,                  style:                  ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),                  onChanged: (String value) {                    setState(() {                      // searchAirportController.text = value.toLowerCase();                      //  Future.delayed(const Duration(milliseconds: 100));                    });                  },                  decoration: ReusingWidgets.SearchTextFormField(                    hintText: "Search for an Airport",                  ),                ),              ),              Expanded(                child: Container(                  color: Colors.white,                  child: Column(                    children: [                      Flexible(                        child: ListView.builder(                          padding: EdgeInsets.all(5),                          itemCount: items.length,                          itemBuilder: (context, index) {                            String cityName = items[index]["iata_code"]  ?? "---";                            // String cityShortName = snapshot.data!.request!.client!.geo!.continent  ?? "---";                            String countryShortName = items[index]["country_code"] ?? "---";                            String airportName = items[index]["name"] ?? "---";                            String iataValue = items[index]["iata_code"]  ?? "---";                            return                              cityName.toLowerCase().contains(searchAirportController.text) ||                              airportName.toLowerCase().contains(searchAirportController.text) ?                              // airportName.where((a) => (a.dataTitle.toLowerCase().contains(searchAirportController.text.toLowerCase().trim()))).toList()                              // items.where((e)=>e.toLowerCase().contains(searchAirportController.text.toLowerCase())).toList()                              //     ?                              InkWell(                                  onTap: () async {                                    Navigator.push(context, MaterialPageRoute(builder: (context){                                      return AirportScreenDetail(airportName: airportName,iataValue: iataValue,);                                    }));                                  },                                  child: ListTile(                                    title: Text(                                      "$cityName,"                                          " $countryShortName",                                      style: ThemeTexts.textStyleValueBlack,                                    ),                                    // subtitle: Text("$cityShortName -  $airportName",                                    subtitle: Text(airportName,                                        style: ThemeTexts.textStyleValueBlack2),                                    trailing: FlutterLogo(                                      size: 30,                                      textColor: Colors.blue,                                      style: FlutterLogoStyle.stacked,                                    ), //F                                  )) : Container();                          },                        ),                      ),                    ],                  ),                ),              ),            ],          ),        ),      ),    );  }}
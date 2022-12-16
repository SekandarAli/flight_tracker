// ignore_for_file: prefer_const_constructorsimport 'dart:async';import 'dart:convert';import 'package:flight_tracker/airports/screen/airport_screen_detail.dart';import 'package:flight_tracker/app_theme/color.dart';import 'package:flight_tracker/app_theme/reusing_widgets.dart';import 'package:flight_tracker/app_theme/theme_texts.dart';import 'package:flight_tracker/functions/function_progress_indicator.dart';import 'package:flutter/material.dart';import 'package:flutter/services.dart';import 'package:hive_flutter/adapters.dart';import '../../recent_airport_airline_search/model/model_recent_search.dart';class AirportsScreen extends StatefulWidget {  AirportsScreen({super.key});  @override  State<AirportsScreen> createState() => _AirportsScreenState();}class _AirportsScreenState extends State<AirportsScreen> {  TextEditingController searchAirportController = TextEditingController();  List beforeSearch = [];  List afterSearch = [];  String query = '';  ModelRecentSearch? modelMyFlights;  Box<ModelRecentSearch>? dataBox;  @override  void initState() {    super.initState();    setState(() {      readJson();      dataBox = Hive.box<ModelRecentSearch>("modelRecentSearch");    });  }  Future<void> readJson() async {    final String response =        await rootBundle.loadString('assets/json/airport.json');    final data = await json.decode(response);    setState(() {      beforeSearch = data["response"];    });  }  void setResults(String query) {    afterSearch = beforeSearch        .where((elem) => elem['iata_code'].toString().toLowerCase().contains(query.toLowerCase()) ||        elem['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();  }  @override  Widget build(BuildContext context) {    double h = MediaQuery.of(context).size.height;    double w = MediaQuery.of(context).size.width;    return Scaffold(      backgroundColor: ColorsTheme.primaryColor,      body: SafeArea(        child: Container(          color: ColorsTheme.white,          child: Column(            children: [              ReusingWidgets.SearchTextFormField(                hintText: "Search for an Airport",                textEditingController: searchAirportController,                onChange: (v) {                  setState(() {                    query = v;                    setResults(query);                  });                },                  onTapClear: (){                  setState(() {                    query = "";                    searchAirportController.clear();                  });                  }              ),              Expanded(                child: Container(                    width: MediaQuery.of(context).size.width,                    decoration: BoxDecoration(                      color: ColorsTheme.primaryColor,                      borderRadius: BorderRadius.only(                        topRight: Radius.circular(50),                        topLeft: Radius.circular(50),                      ),                    ),                    padding: EdgeInsets.only(left: 20, right: 20, top: 30),                    child: Column(                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [                        Text(                          "All Airports",                          style: ThemeTexts.textStyleTitle1                              .copyWith(color: Colors.white, fontSize: 20),                        ),                        SizedBox(height: 20),                        Expanded(                            child: Container(                              width: MediaQuery.of(context).size.width,                              padding: EdgeInsets.all(0),                              decoration: BoxDecoration(                            color: ColorsTheme.white,                            borderRadius: BorderRadius.only(                              topRight: Radius.circular(20),                              topLeft: Radius.circular(20),                            ),                          ),                          child: Column(                            children: [                              searchAirportController.text.isNotEmpty ? Container() : Column(                                crossAxisAlignment: CrossAxisAlignment.start,                                children: [                                  Text("\n\t\tRecent",style: ThemeTexts.textStyleTitle2                                      .copyWith(color: ColorsTheme.primaryColor, ),),                                  SizedBox(                                    height: h * 0.15,                                    width: w,                                    child: ValueListenableBuilder<Box<ModelRecentSearch>>(                                      valueListenable:                                      Hive.box<ModelRecentSearch>("modelRecentSearch").listenable(),                                      builder: (context, box, _) {                                        final items = box.values.toList().cast<ModelRecentSearch>();                                        if (items.isEmpty) {                                          return Container();                                        } else {                                          return Flex(                                              direction: Axis.vertical,                                              children: [                                                Expanded(                                                  child: ListView.builder(                                                    itemCount: box.values.length,                                                    itemBuilder: (context, index) {                                                      ModelRecentSearch? currentTask = box.getAt(index);                                                      String airportName = currentTask!.name ?? "---";                                                      String iataValue = currentTask.cityShortCode ?? "---";                                                      return                                                        ListTile(                                                          onTap: () async {                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {                                                              return AirportScreenDetail(                                                                airportName: airportName,                                                                iataValue: iataValue,                                                              );                                                            }));                                                          },                                                          leading: Icon(Icons.history),                                                          title: Text(                                                              "${currentTask.countryShortCode!},"" ${currentTask.cityShortCode!}",                                                              style: ThemeTexts                                                                  .textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),                                                          subtitle: Text(currentTask.name!,                                                              style: ThemeTexts                                                                  .textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),                                                        );                                                    },                                                  ),                                                ),]                                          );                                        }                                      },                                    ),                                  ),                                ],                              ),                              Align(                                alignment: Alignment.topLeft,                                child: Text("\n\t\tAll",style: ThemeTexts.textStyleTitle2                                    .copyWith(color: ColorsTheme.primaryColor, ),),                              ),                              Flexible(                                child: query.isEmpty ?                                ListView.builder(                                  padding: EdgeInsets.all(5),                                  shrinkWrap: true,                                  itemCount: beforeSearch.length,                                  itemBuilder: (context, index) {                                    String cityName = beforeSearch[index]["iata_code"] ?? "---";                                    String countryShortName = beforeSearch[index]["country_code"] ?? "---";                                    String airportName = beforeSearch[index]["name"] ?? "---";                                    String iataValue = beforeSearch[index]["iata_code"] ?? "---";                                    print(beforeSearch.length);                                    return                                         ListTile(                                           title: Text(                                             "$cityName,"" $countryShortName",                                             style: ThemeTexts                                                 .textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),                                           subtitle: Text(airportName,                                               style: ThemeTexts                                                   .textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),                                           onTap: () async {                                             Navigator.push(context, MaterialPageRoute(builder: (context) {                                               return AirportScreenDetail(                                                 airportName: airportName,                                                 iataValue: iataValue,                                               );                                             }));                                             modelMyFlights = ModelRecentSearch(                                                 name: airportName,                                                 cityShortCode: cityName,                                                 countryShortCode: countryShortName                                             );                                             dataBox!.add(modelMyFlights!);                                           },                                         );                                  },                                )                                    :                                afterSearch.isEmpty ? NoSearchFound() : ListView.builder(                                  padding: EdgeInsets.all(5),                                  shrinkWrap: true,                                  itemCount: afterSearch.length,                                  itemBuilder: (context, index) {                                    String cityName = afterSearch[index]["iata_code"] ?? "---";                                    String countryShortName = afterSearch[index]["country_code"] ?? "---";                                    String airportName = afterSearch[index]["name"] ?? "---";                                    String iataValue = afterSearch[index]["iata_code"] ?? "---";                                    print("aaaaa${afterSearch.length}");                                    return                                      ListTile(                                        title: Text(                                            "$cityName,"" $countryShortName",                                            style: ThemeTexts                                                .textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),                                        subtitle: Text(airportName,                                            style: ThemeTexts                                                .textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),                                        onTap: () async {                                          Navigator.push(context, MaterialPageRoute(builder: (context) {                                            return AirportScreenDetail(                                              airportName: airportName,                                              iataValue: iataValue,                                            );                                          }));                                          modelMyFlights = ModelRecentSearch(                                              name: airportName,                                              cityShortCode: cityName,                                              countryShortCode: countryShortName                                          );                                          dataBox!.add(modelMyFlights!);                                        },                                      );                                  },                                )                              ),                            ],                          ),                        )),                      ],                    )),              ),            ],          ),        ),      ),    );  }  //  // WidgetairportListTile(){  //   return InkWell(  //       onTap: () async {  //         Navigator.push(context, MaterialPageRoute(builder: (context) {  //           return AirportScreenDetail(  //             airportName: airportName,  //             iataValue: iataValue,  //           );  //         }));  //       },  //       child: ListTile(  //         title: Text(  //             "$cityName,"" $countryShortName",  //             style: ThemeTexts  //                 .textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),  //         subtitle: Text(airportName,  //             style: ThemeTexts  //                 .textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),  //       ))  // }}
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flight_tracker/airlines/model/model_airlines.dart';
import 'package:flight_tracker/airlines/screen/airline_screen_detail.dart';
import 'package:flight_tracker/airlines/services/services_airlines.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/city_name_model.dart';

class AirlineScreen extends StatefulWidget {

  AirlineScreen({super.key});

  @override
  State<AirlineScreen> createState() => _AirlineScreenState();
}

class _AirlineScreenState extends State<AirlineScreen> {

  TextEditingController searchAirlineController = TextEditingController();
  List beforeSearch = [];
  List cityy = [];

  List afterSearch = [];
  String query = '';
   late List<CityNameModel> cityName = [CityNameModel(cityCode: 'ISB', cityName: 'Islamabad'),
    CityNameModel(cityCode: 'DXB', cityName: 'Dubai'),
    CityNameModel(cityCode: 'KHI', cityName: 'Karachi'),
    CityNameModel(cityCode: 'LHE', cityName: 'Lahore'),
    CityNameModel(cityCode: 'CLR', cityName: 'California'),
    CityNameModel(cityCode: 'VRG', cityName: 'Virgina'),
    CityNameModel(cityCode: 'GRG', cityName: 'Gorgiea'),
  ];

  String? getCityName(String cityCode){
    String city = '';
    // log('Need city code ${cityCode}');
    for (int i = 0; i < cityy.length ; i++) {
      if(cityCode == cityy[i]["city_code"]){
        // log('city code ${cityy[i]["name"]}');
        city= cityy[i]["name"];

      }
    }
    // log('city : $city');
    return city;

  }



  @override
  void initState() {
    super.initState();

    setState(() {
      readJson();
      readJsonCity();
    });
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/airline.json');
    final data = await json.decode(response);
    setState(() {
      beforeSearch = data["response"];
    });
  }


  Future<void> readJsonCity() async {
    final String response = await rootBundle.loadString('assets/json/city.json');
   // final String response = await rootBundle.loadString('assets/json/airline.json');
    final data = await json.decode(response);
    setState(() {
      cityy = data["response"];
    });
    cityName = [];
    for (int i = 0; i < cityy.length ; i++) {
      cityName.add(CityNameModel(cityCode: cityy[i]["city_code"], cityName: cityy[i]["name"]));
    }

  for (var element in cityName) {
    // log(element.cityName.toString());
  }

  }

  void setResults(String query) {
    afterSearch = beforeSearch
        .where((elem) => elem['iata_code'].toString().toLowerCase().contains(query.toLowerCase()) ||
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
                  }, context: context,
                  backIconStatus: false
              ),
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
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
                              width: MediaQuery.of(context).size.width,
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
                                        itemCount: beforeSearch.length,
                                        itemBuilder: (context, index) {

                                          String? airlineName = beforeSearch[index]["name"]  ?? "Unknown";
                                          String? countryShortName = beforeSearch[index]["iata_code"]  ?? "Unknown";
                                          String? iataValue = beforeSearch[index]["icao_code"]  ?? "Unknown";
                                          String? airportImage;

                                          return
                                            InkWell(
                                                onTap: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return AirlineScreenDetails(airlineName: airlineName,iataValue: iataValue!,);
                                                  }));
                                                },
                                                child: ListTile(
                                                  title: Text(airlineName!,style: ThemeTexts.textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                                                  subtitle: Text(/*getCityName(iataValue.toString())!*/countryShortName!,style: ThemeTexts.textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),
                                                ));
                                        },
                                    )
                                        :
                                    afterSearch.isEmpty ? NoSearchFound() : ListView.builder(
                                      padding: EdgeInsets.all(5),
                                      shrinkWrap: true,
                                      itemCount: afterSearch.length,
                                      itemBuilder: (context, index) {

                                        String? airlineName = afterSearch[index]["name"]  ?? "Unknown";
                                        String? countryShortName = afterSearch[index]["iata_code"]  ?? "Unknown";
                                        String? iataValue = afterSearch[index]["icao_code"]  ?? "Unknown";
                                        String? airportImage;

                                        return
                                          InkWell(
                                              onTap: () async {
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return AirlineScreenDetails(airlineName: airlineName,iataValue: iataValue!,);
                                                }));
                                              },
                                              child: ListTile(
                                                title: Text(airlineName!,style: ThemeTexts.textStyleValueBlack.copyWith(fontWeight: FontWeight.bold,fontSize: 14)),
                                                subtitle: Text(getCityName(iataValue.toString())!/*countryShortName!*/,style: ThemeTexts.textStyleValueBlack2.copyWith(color: ColorsTheme.themeColor)),
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

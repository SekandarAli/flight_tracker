// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../app_theme/color.dart';

class SearchTabRecentSearches extends StatefulWidget {
   SearchTabRecentSearches({Key? key,
     this.departureAirportShortName,
     this.departureAirport,
     this.arrivalAirportShortName,
     this.arrivalAirport,
   }) : super(key: key);

   String? departureAirport;
   String? arrivalAirport;
   String? departureAirportShortName;
   String? arrivalAirportShortName;

  @override
  State<SearchTabRecentSearches> createState() => _SearchTabRecentSearchesState();
}

class _SearchTabRecentSearchesState extends State<SearchTabRecentSearches> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  SizedBox(
      height: h * 0.4,
      width: w,
      child: ValueListenableBuilder<Box<ModelSearch>>(
        valueListenable:
        Hive.box<ModelSearch>("modelSearch").listenable(),
        builder: (context, box, _) {
          final items = box.values.toList().cast<ModelSearch>();

          if (items.isEmpty) {
            return Container();
          } else {
            return Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        ModelSearch? currentTask = box.getAt(index);
                        return Card(
                          color: ColorsTheme.lightGreenPrimary,
                          elevation: 5,
                          child: Container(
                            width: w,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      // var departureAirport = currentTask.departureCity!;
                                      // var departureAirportShortName = currentTask.departureCityShortName!;
                                      // var arrivalAirport = currentTask.arrivalCity!;
                                      // var arrivalAirportShortName = currentTask.arrivalCityShortName!;
                                    });
                                  },
                                  child: SizedBox(
                                    width: w * 0.7,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.history,color: ColorsTheme.primaryColor,),
                                        SizedBox(width: 10,),
                                        Row(
                                          children: [
                                            Text("${currentTask!.departureCityShortName}   ", style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular",fontSize: 12)),
                                            Icon(Icons.flight_takeoff,color: ColorsTheme.themeColor,),
                                            Text("   ${currentTask.arrivalCityShortName}", style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(icon: Icon(Icons.clear),color: Colors.grey,
                                  onPressed: (){
                                    currentTask.delete();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),]
            );
          }
        },
      ),
    );
  }
}

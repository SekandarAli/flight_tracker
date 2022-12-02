// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
    return SizedBox(
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
                        return Container(
                          width: w,
                          padding: EdgeInsets.only(left: 6,bottom: 6),
                          margin: EdgeInsets.only(left: 6,bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    print("aaaaaaaaa");
                                    widget.departureAirport = currentTask.departureCity!;
                                    widget.departureAirportShortName = currentTask.departureCityShortName!;
                                    widget.arrivalAirport = currentTask.arrivalCity!;
                                    widget.arrivalAirportShortName = currentTask.arrivalCityShortName!;
                                  });
                                },
                                child: SizedBox(
                                  width: w * 0.7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.history,color: Colors.grey,),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(color: Colors.black, fontSize: 60),
                                            children: [
                                              TextSpan(text: 'From  ',style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.normal,fontFamily: "OpenSansRegular")),
                                              TextSpan(text: currentTask!.departureCity, style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                              TextSpan(text: '  to  ',style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.normal,fontFamily: "OpenSansRegular")),
                                              TextSpan(text: currentTask.arrivalCity, style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                            ],
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                      ),
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

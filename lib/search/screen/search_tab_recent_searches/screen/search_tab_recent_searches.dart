// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SearchTabRecentSearches extends StatefulWidget {
  const SearchTabRecentSearches({Key? key}) : super(key: key);

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
                              SizedBox(
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
                                            TextSpan(text: 'From  ',style: ThemeTexts.textStyleTitle1.copyWith(fontWeight: FontWeight.normal,fontFamily: "OpenSansRegular")),
                                            TextSpan(text: currentTask!.departureCity, style: ThemeTexts.textStyleTitle1.copyWith(fontFamily: "OpenSansRegular")),
                                            TextSpan(text: '  to  ',style: ThemeTexts.textStyleTitle1.copyWith(fontWeight: FontWeight.normal,fontFamily: "OpenSansRegular")),
                                            TextSpan(text: currentTask.arrivalCity, style: ThemeTexts.textStyleTitle1.copyWith(fontFamily: "OpenSansRegular")),
                                          ],
                                        ),
                                        textScaleFactor: 0.5,
                                      ),
                                    ),
                                  ],
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

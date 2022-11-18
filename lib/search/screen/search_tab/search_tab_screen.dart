// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/search/screen/search_qr_code/search_qrcode.dart';
import 'package:flight_tracker/search/screen/search_tab_by_flightcode/search_tab_by_flightcode.dart';
import 'package:flight_tracker/search/screen/search_tab_by_route/search_tab_by_route.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
                children: [
                  selectTabs(),
                  index == 1 ?
                  SearchTabByRoute() :
                      index == 2 ?
                      SearchTabByFlightCode() :
                          Container()
                ],
          ),
        ),
      ),
    );
  }

  Widget selectTabs() {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ReusingWidgets().searchModuleTabBar(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              context: context,
              text: "BY ROUTE",
              textColor: index == 1 ? ColorsTheme.white : Colors.white54,
              borderColor: index == 1 ? ColorsTheme.white : ColorsTheme.primaryColor,
              borderWidth: index == 1 ? 3 : 1),
          ReusingWidgets().searchModuleTabBar(
              onTap: () {
                setState(() {
                  index = 2;
                });
              },
              context: context,
              text: "BY FLIGHT CODE",
              textColor: index == 2 ? ColorsTheme.white : Colors.white54,
              borderColor: index == 2 ? ColorsTheme.white : ColorsTheme.primaryColor,
              borderWidth: index == 2 ? 3 : 1),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchQrCode()));
              },
              child: Icon(Icons.qr_code_scanner_rounded,color: Colors.white,size: MediaQuery.of(context).size.width * 0.1)),
        ],
      ),
    );
  }
}

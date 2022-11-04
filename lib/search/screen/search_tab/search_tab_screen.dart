// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flutter/material.dart';
import 'search_tab_by_flightcode/search_tab_by_flightcode.dart';
import 'search_tab_by_route/search_tab_by_route.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      animationDuration: Duration.zero,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                physics: NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.all(10),
                labelPadding: EdgeInsets.all(15),
                tabs: [
                  ReusingWidgets.tapBarText(text: "BY ROUTE"),
                  ReusingWidgets.tapBarText(text: "BY FLIGHT CODE"),
                  // Icon(Icons.qr_code_scanner_rounded)
                ],
              ),
              // Icon(Icons.qr_code_scanner_rounded)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchTabByRoute(),
            SearchTabByFlightCode()
          ],
        ),
      ),
    );
  }
}

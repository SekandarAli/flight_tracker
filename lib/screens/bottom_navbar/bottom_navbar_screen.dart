// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flutter/material.dart';

import 'search/search_tab_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return SearchScreen();
      // case 1:
      //   return EstimatesScreen();
      // case 2:
      //   return ClientsScreen();
      // case 3:
      //   return ToolsScreen();
      // case 4:
      //   return ReportScreen();

      default:
        return Center(child: Text("Error"));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: ColorsTheme.primaryColor,
        unselectedItemColor: Colors.grey[400],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
            // activeIcon: Icon(Icons.inventory_2_rounded),
          ),

          BottomNavigationBarItem(
            label: 'My Flights',
            icon: Icon(Icons.flight_takeoff),
          ),

          BottomNavigationBarItem(
            label:"Airports",
            icon: Icon(Icons.houseboat_rounded),
          ),

          BottomNavigationBarItem(
            label: "Airlines",
            icon: Icon(Icons.line_style_outlined),
          ),

          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings),
          ),

        ],
      ),
      body: _getDrawerItemWidget(_currentIndex),
    );
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/airlines/screen/airline_screen.dart';
import 'package:flight_tracker/airports/screen/airports_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_screen.dart';
import 'package:flight_tracker/settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 2;

  _getDrawerItemWidget(int position) {
    switch (position) {
      case 0:
        return SearchScreen();
      case 1:
        return MyFlightsScreen();
      case 2:
        return AirportsScreen();
      case 3:
        return AirlineScreen();
      case 4:
        return SettingsScreen();

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
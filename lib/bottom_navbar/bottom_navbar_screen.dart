// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/ads/ad_mobs_manager.dart';
import 'package:flight_tracker/airlines/screen/airline_screen.dart';
import 'package:flight_tracker/useless/airports_screen.dart';
import 'package:flight_tracker/airports/screen/airport_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_screen.dart';
import 'package:flight_tracker/settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../useless/airlines_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  int currentIndex = 1;

  late BannerAd _bannerAd;
  bool isBannerAdLoaded = false;

  final box = GetStorage();


  initBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdMobsManager.bannerApp_Id,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            setState(() {
              isBannerAdLoaded = true;
            });
          },
          onAdOpened: (Ad ad) => print("Ad Opened"),
          onAdClosed: (Ad ad) => print("Ad Closed"),
          onAdImpression: (Ad ad) => print("Ad Impression"),
          onAdFailedToLoad: (Ad ad, LoadAdError loadAdError) {
            ad.dispose();
            print("Ad Failed to load $loadAdError");
          }),
    );

    _bannerAd.load();
  }

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
    initBannerAd();
    _bannerAd.load();
    _initGoogleMobileAds();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {

    // box.writeIfNull('currentIndex', currentIndex);

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [

          isBannerAdLoaded ? Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble() * 0.7,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        ReusingWidgets().snackBar(context: context, text: "Go Premium");
                      },
                      icon: Icon(Icons.clear,color: ColorsTheme.primaryColor,),
                    ),
                ),
              ),
              SizedBox(
                width: _bannerAd.size.width.toDouble() * 0.65,
                height: _bannerAd.size.height.toDouble() * 0.7,
                child: AdWidget(ad: _bannerAd),
              ),

            ],
          ) : SizedBox(),

          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            // currentIndex: int.parse('${box.read("currentIndex")}'),
            backgroundColor: Colors.white,
            selectedItemColor: ColorsTheme.primaryColor,
            unselectedItemColor: Colors.grey[400],
            onTap: (value) {
              setState(() {
                // box.write("currentIndex", currentIndex);
                currentIndex = value;
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
        ],
      ),
      body: _getDrawerItemWidget(currentIndex),
    );
  }
}
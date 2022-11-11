// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flight_tracker/ads/ad_mobs_implement.dart';
import 'package:flight_tracker/airlines/screen/airline_screen.dart';
import 'package:flight_tracker/airports/screen/airports_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_screen.dart';
import 'package:flight_tracker/settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  int currentIndex = 0;

  late BannerAd _bannerAd;
  bool isBannerAdLoaded = false;

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
    // var cart = Provider.of<ProviderData>(context);
    // var subTotal = cart.currentIndex;
    // int currentIndex = 0;

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [

          isBannerAdLoaded ? SizedBox(
            width: _bannerAd.size.width.toDouble() * 0.7,
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          ) : SizedBox(),

          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: ColorsTheme.primaryColor,
            unselectedItemColor: Colors.grey[400],
            onTap: (value) {
              setState(() {
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
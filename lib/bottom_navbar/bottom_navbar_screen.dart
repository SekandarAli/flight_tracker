// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers

import 'dart:io';

import 'package:flight_tracker/airlines/screen/airline_screen.dart';
import 'package:flight_tracker/settings/screen/setting_screen.dart';
import 'package:flight_tracker/airports/screen/airport_screen.dart';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
import 'package:flight_tracker/search/screen/search_tab/search_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../app_theme/reusing_widgets.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> with TickerProviderStateMixin{

  late BannerAd _bannerAd;
  bool isBannerAdLoaded = false;
  DateTime? currentTime;

  int tabIndex = 0;
  late TabController tabController = TabController(length: 4, vsync: this,animationDuration: Duration(microseconds: 1));

  @override
  void initState() {
    super.initState();
    setState(() {
    });


    tabController.addListener(() {
      if (tabController.index == 0) {
        setState(() {
          tabIndex = 0;
          tabController.index = tabIndex;
        });
      }
      else if (tabController.index == 1) {
        setState(() {
          tabIndex = 1;
          tabController.index = tabIndex;
        });
      }
      else if (tabController.index == 2) {
        setState(() {
          tabIndex = 2;
          tabController.index = tabIndex;
        });
      }
      else if (tabController.index == 3) {
        setState(() {
          tabIndex = 3;
          tabController.index = tabIndex;
        });
      }
      // else if (tabController.index == 4) {
      //   setState(() {
      //     tabIndex = 4;
      //     tabController.index = tabIndex;
      //   });
      // }
    });
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
    return WillPopScope(
      onWillPop: ()
    {
      if (tabController.index == 0)
      {
        DateTime now = DateTime.now();
        if (currentTime == null || now.difference(currentTime!) > Duration(seconds: 2))
        {
          currentTime = now;
          ReusingWidgets().snackBar(context: context, text: "Press Back Button Again to Exit");
          return Future.value(false);
        }
        return Future.value(true);
          }
      else {
            tabIndex = 0;
            tabController.index = tabIndex;
          }
        return null!;
      },
      child: Scaffold(
        // drawer: Drawer(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomAppBar(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  color: ColorsTheme.white,
                  height: 60,
                  padding: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            tabIndex = 0;
                            tabController.index = tabIndex;
                          },
                          child: bottomWidget(
                            0,
                            "Search",
                            Icons.search,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            tabIndex = 1;
                            tabController.index = tabIndex;
                          },
                          child: bottomWidget(
                            1,
                            "My Flights",
                              Icons.flight_takeoff,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              tabIndex = 2;
                              tabController.index = tabIndex;
                            },
                            child: bottomWidget(
                              2,
                              "Airports",
                              Icons.houseboat_rounded,
                            )),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            tabIndex = 3;
                            tabController.index = tabIndex;
                          },
                          child: bottomWidget(
                            3,
                            "Airlines",
                            Icons.line_style_outlined,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       tabIndex = 4;
                      //       tabController.index = tabIndex;
                      //     },
                      //     child: bottomWidget(
                      //       4,
                      //       "Settings",
                      //       Icons.settings,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )),
            // activeConnection == true ? Container() : Container(
            //   height: 20,
            //   color: Colors.black,width: double.infinity,
            //   child: Center(child: Text("No Internet Connection",style: TextStyle(color: Colors.white),),),
            // )
          ],
        ),
        body: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: SearchScreen(),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: MyFlightsScreen(),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: AirportsScreen(),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: AirlineScreen(),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   height: double.infinity,
                      //   alignment: Alignment.center,
                      //   child: SettingsScreen(),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget bottomWidget(int index, String title, IconData icon) {
    return Column(
      children: [

        Icon(icon,
          color: tabIndex == index
            ? ColorsTheme.primaryColor
            : ColorsTheme.lightGrey,),
        Text(
          title,
          style: TextStyle(
            color: tabIndex == index
                ? ColorsTheme.primaryColor
                : ColorsTheme.lightGrey,
    // style: ThemeTexts.textStyleTitle3.copyWith(
    //         color: tabIndex == index
    //             ? ColorsTheme.primaryColor
    //             : ColorsTheme.lightGrey,
          )
        )
      ],
    );
  }

}


//
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers
//
// import 'package:flight_tracker/ads/ad_mobs_manager.dart';
// import 'package:flight_tracker/airlines/screen/airline_screen.dart';
// import 'package:flight_tracker/settings/screen/setting_screen.dart';
// import 'package:flight_tracker/airports/screen/airport_screen.dart';
// import 'package:flight_tracker/app_theme/color.dart';
// import 'package:flight_tracker/app_theme/reusing_widgets.dart';
// import 'package:flight_tracker/myflights/screen/myflights_screen.dart';
// import 'package:flight_tracker/search/screen/search_tab/search_tab_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// import '../app_theme_work/theme_colors.dart';
//
// class BottomNavBarScreen extends StatefulWidget {
//   const BottomNavBarScreen({Key? key}) : super(key: key);
//
//   @override
//   _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
// }
//
// class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
//   int currentIndex = 1;
//
//   late BannerAd _bannerAd;
//   bool isBannerAdLoaded = false;
//
//   DateTime? currentTime;
//
//   final box = GetStorage();
//
//   initBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: AdMobsManager.bannerApp_Id,
//       size: AdSize.fullBanner,
//       request: AdRequest(),
//       listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             setState(() {
//               isBannerAdLoaded = true;
//             });
//           },
//           onAdOpened: (Ad ad) => print("Ad Opened"),
//           onAdClosed: (Ad ad) => print("Ad Closed"),
//           onAdImpression: (Ad ad) => print("Ad Impression"),
//           onAdFailedToLoad: (Ad ad, LoadAdError loadAdError) {
//             ad.dispose();
//             print("Ad Failed to load $loadAdError");
//           }),
//     );
//
//     _bannerAd.load();
//   }
//
//   _getDrawerItemWidget(int position) {
//     switch (position) {
//       case 0:
//         return SearchScreen();
//       case 1:
//         return MyFlightsScreen();
//       case 2:
//         return AirportsScreen();
//       case 3:
//         return AirlineScreen();
//       case 4:
//         return SettingsScreenNew();
//
//       default:
//         return Center(child: Text("Error"));
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // initBannerAd();
//     // _bannerAd.load();
//     // _initGoogleMobileAds();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd.dispose();
//     super.dispose();
//   }
//
//   Future<InitializationStatus> _initGoogleMobileAds() {
//     return MobileAds.instance.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             isBannerAdLoaded
//                 ? Stack(
//                     alignment: AlignmentDirectional.topStart,
//                     children: [
//                       Container(
//                         width: _bannerAd.size.width.toDouble(),
//                         height: _bannerAd.size.height.toDouble() * 0.7,
//                         color: Colors.white,
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: IconButton(
//                             onPressed: () {
//                               ReusingWidgets().snackBar(
//                                   context: context, text: "Go Premium");
//                             },
//                             icon: Icon(
//                               Icons.clear,
//                               color: ColorsTheme.primaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: _bannerAd.size.width.toDouble() * 0.65,
//                         height: _bannerAd.size.height.toDouble() * 0.7,
//                         child: AdWidget(ad: _bannerAd),
//                       ),
//                     ],
//                   )
//                 : SizedBox(),
//             Container(
//               // height: 80,
//               // decoration: BoxDecoration(
//               //   border: Border.all(
//               //       color: Colors.white,
//               //       width: 4.0,
//               //       style: BorderStyle.solid),
//               //   borderRadius: BorderRadius.only(
//               //     topRight: Radius.circular(30),
//               //     topLeft: Radius.circular(30),
//               //   ),
//               // ),
//               child: BottomNavigationBar(
//                 type: BottomNavigationBarType.fixed,
//                 currentIndex: currentIndex,
//                 backgroundColor: Colors.white,
//                 selectedItemColor: ColorsTheme.primaryColor,
//                 unselectedItemColor: Colors.grey[400],
//                 onTap: (value) {
//                   setState(() {
//                     currentIndex = value;
//                   });
//                 },
//                 items: [
//                   BottomNavigationBarItem(
//                     label: "Search",
//                     icon: Icon(Icons.search),
//                     // activeIcon: Icon(Icons.inventory_2_rounded),
//                   ),
//                   BottomNavigationBarItem(
//                     label: 'My Flights',
//                     icon: Icon(Icons.flight_takeoff),
//                   ),
//                   BottomNavigationBarItem(
//                     label: "Airports",
//                     icon: Icon(Icons.houseboat_rounded),
//                   ),
//                   BottomNavigationBarItem(
//                     label: "Airlines",
//                     icon: Icon(Icons.line_style_outlined),
//                   ),
//                   BottomNavigationBarItem(
//                     label: "Settings",
//                     icon: Icon(Icons.settings),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         body: WillPopScope(
//           onWillPop: () {
//             DateTime now = DateTime.now();
//             if (currentTime == null || now.difference(currentTime!) > Duration(seconds: 2)) {
//               currentTime = now;
//               ReusingWidgets().snackBar(context: context, text: "Press Back Button Again to Exit");
//               return Future.value(false);
//             }
//             return Future.value(true);
//           },
//           child: _getDrawerItemWidget(currentIndex),
//         ));
//   }
//
// }

// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobsManager {
  AdMobsManager._();

  /// Testing IDS

  static final android_test_app_id = "ca-app-pub-3940256099942544~3347511713";
  static final android_test_banner_id = "ca-app-pub-3940256099942544/6300978111";

  static final ios_app_id = "ca-app-pub-3940256099942544~1458002511";
  static final ios_banner_id = "ca-app-pub-3940256099942544/2934735716";

  static final window_test_app_id = "ca-app-pub-3940256099942544~3347511713";
  static final window_test_banner_id = "ca-app-pub-3940256099942544/6300978111";


  static String get app_Id {
    if (Platform.isAndroid) {
      return android_test_app_id;
    } else if (Platform.isIOS) {
      return ios_app_id;
    } else if(Platform.isWindows){
      return window_test_app_id;
    } else {
      return throw UnsupportedError("Error in Banner");
    }
  }

  static String get bannerApp_Id {
    if (Platform.isAndroid) {
      return android_test_banner_id;
    } else if (Platform.isIOS) {
      return ios_banner_id;
    } else if(Platform.isWindows){
      return window_test_banner_id;
    }
    else {
      return throw UnsupportedError("Error in Banner");
    }
  }

  static BannerAd createBannerAd() {
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerApp_Id,
      request: AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print("Banner Loaded"),
          onAdOpened: (Ad ad) => print("Ad Opened"),
          onAdClosed: (Ad ad) => print("Ad Closed"),
          onAdImpression: (Ad ad) => print("Ad Impression"),
          onAdFailedToLoad: (Ad ad, LoadAdError loadAdError) {
            ad.dispose();
            print("Ad Failed to load $loadAdError");
          }),
    );
    return bannerAd;
  }
}
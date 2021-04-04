import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      print(env['ADMOB_APP_ID']);
      
    }
    return null;
  }

  static String _getBannerAdId() {
    if (Platform.isAndroid) {
      return env['ADMOB_AD_ID'];
    }
    return null;
  }

  static BannerAd banner;

  static void createBannerAd() {
    banner = BannerAd(
      adUnitId: _getBannerAdId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('${ad.runtimeType} loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('${ad.runtimeType} opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed');
          ad.dispose();
          createBannerAd();
          print('${ad.runtimeType} reloaded');
        },
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    )..load();
  }
}

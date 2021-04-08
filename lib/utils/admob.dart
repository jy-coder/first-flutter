import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  static AdWidget adWidget = AdWidget(ad: banner);
  static AdWidget publisherAd = AdWidget(ad: myBanner);
  static List<AdWidget> adLists;
  static BannerAd banner;
  static PublisherBannerAd myBanner;

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

  static PublisherAdRequest request = PublisherAdRequest(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.dev',
    customTargetingLists: <String, List<String>>{
      'favoriteColors': <String>['red', 'yellow']
    },
  );

  static AdListener listener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );

  static void createPublishAd() {
    myBanner = PublisherBannerAd(
      adUnitId: _getBannerAdId(),
      sizes: [AdSize.banner],
      request: request,
      listener: listener,
    )..load();
  }

  static List<AdWidget> generateAds(int maxAds) {
    List<AdWidget> records = [];
    for (int i = 0; i < maxAds; i++) {
      createPublishAd();
      records.add(AdWidget(ad: myBanner));
    }
    return records;
  }
}

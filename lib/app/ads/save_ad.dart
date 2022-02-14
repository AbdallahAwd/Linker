import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:linker/app/ads/ad_helper.dart';

class SaveAd {
  static InterstitialAd? _ad;
  static bool isAddReady = false;

  static void loadSaveAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.saveAd,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            isAddReady = true;
            _ad = ad;
          },
          onAdFailedToLoad: (error) {
            log(error.toString());
          },
        ));
  }

  static void showSaveAd() {
    if (isAddReady) {
      _ad!.show();
    }
  }
}

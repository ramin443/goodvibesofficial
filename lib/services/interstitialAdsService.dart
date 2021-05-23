import 'package:firebase_admob/firebase_admob.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';

class InterstitialAdsService {
  InterstitialAd _interstitialAd = createInterstitialAd()..load();

  static final InterstitialAdsService _interstitialAdsService =
  InterstitialAdsService._internal();

  factory InterstitialAdsService() {
    return _interstitialAdsService;
  }

  InterstitialAdsService._internal();

  Future<bool> get isLoaded async {
    final res = (await _interstitialAd.isLoaded()) ?? false;
    return res;
  }

  InterstitialAd get getInterstitialAds => _interstitialAd;

  show() {
    _interstitialAd.show();
  }

  reload() {
    _interstitialAd = createInterstitialAd()..load();
  }
}

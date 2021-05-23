import 'dart:io';

//import 'package:firebase_admob/firebase_admob.dart';

/// admob app id for platforms
const androidAppId = 'ca-app-pub-4284307101881172~6388287871';
const iosAppId = 'ca-app-pub-4284307101881172~6359328012';

/////// test ad ids /////////////
///*******  android: *********** */
const bannerAdTestIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
const interstitialAdTestIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
const rewardViedeoTestIdAndroid = 'ca-app-pub-3940256099942544/5224354917';

///************ ios*********** */
const bannerAdTestIdIos = 'ca-app-pub-3940256099942544/2934735716';
const interstitialAdTestIdIos = 'ca-app-pub-3940256099942544/4411468910';
const interstitialVideoIdIos = 'ca-app-pub-3940256099942544/5135589807';
const rewardViedeoTestIdIos = 'ca-app-pub-3940256099942544/1712485313';

////////// production ad ids://///////////////
///*******  android: *********** */
const bannerAdProdIdAndroid = 'ca-app-pub-4284307101881172/8509038420';
const interstitialAdProdIdAndroid = 'ca-app-pub-4284307101881172/4065828479';
const rewardVideoIdAndroidProd = 'ca-app-pub-4284307101881172/8653856469';
const nativeBannerAdsProd = 'ca-app-pub-4284307101881172/1439665131';

///************ ios*********** */
const bannerAdProdIdIos = 'ca-app-pub-4284307101881172/2594797960';
const interstitialAdProdIdIos = 'ca-app-pub-4284307101881172/4065828479';
const rewardVideoIdIosProd = 'ca-app-pub-4284307101881172/9555874593';
const nativeBannerAdsProdIDIos = "ca-app-pub-4284307101881172/9781189588";
// const Map<String, dynamic> androidIds = {
//   'test_banner': bannerAdTestIdAndroid,
//   'test_inter': interstitialAdTestIdAndroid,
//   'reward_video_ad_test': rewardViedeoTestIdAndroid,
//   'prod_banner': bannerAdProdIdAndroid,
//   'rewardVideoAdId': rewardVideoIdAndroidProd,
// };
// const Map<String, dynamic> iosIds = {
//   'test_banner': bannerAdTestIdIos,
//   'test_inter': interstitialAdTestIdIos,
//   'reward_video_ad_test': rewardViedeoTestIdIos,
//   'prod_banner': bannerAdProdIdIos,
//   'rewardVideoAdId': rewardVideoIdIosProd,
// };

const Map<String, dynamic> ios_prod_ids = {
  'banner': bannerAdProdIdIos,
  'reward': rewardVideoIdIosProd,
};

const Map<String, dynamic> ios_test_ids = {
  'banner': bannerAdTestIdIos,
  'reward': rewardViedeoTestIdIos,
};

const Map<String, dynamic> android_prod_ids = {
  'banner': bannerAdProdIdIos,
  'reward': rewardVideoIdIosProd,
};

const Map<String, dynamic> android_test_ids = {
  'banner': bannerAdTestIdAndroid,
  'reward': rewardViedeoTestIdAndroid,
};

const adIds = {'android': android_prod_ids, 'ios': ios_prod_ids};

String get getAdsAppID {
  if (Platform.isAndroid)
    return androidAppId;
  else
    return iosAppId;
}

String get getRewardID {
  if (Platform.isAndroid)
    return rewardVideoIdAndroidProd;
  else
    return rewardVideoIdIosProd;
}

String get getInterstitialID {
  if (Platform.isAndroid)
    return interstitialAdProdIdAndroid;
  else
    return interstitialAdProdIdIos;
}

String get getAdsUnitID {
  if (Platform.isAndroid)
    return nativeBannerAdsProd;
  else
    return nativeBannerAdsProdIDIos;
}

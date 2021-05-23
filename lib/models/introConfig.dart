class IntroOfferConfig {
  final bool android;
  final bool ios;

  const IntroOfferConfig({this.android, this.ios});

  factory IntroOfferConfig.fromJson(Map json) {
    return IntroOfferConfig(android: json['android'], ios: json['ios']);
  }
}

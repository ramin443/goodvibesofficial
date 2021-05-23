class UIConfig {
  final String uiComponent;
  final bool android;
  final bool ios;
  const UIConfig({this.uiComponent, this.android, this.ios});

  factory UIConfig.fromJson(Map json) {
    return UIConfig(
      uiComponent: 'promos',
      android: json['android'],
      ios: json['ios'],
    );
  }
}

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:rxdart/rxdart.dart';

class DynamicLinkService {
  BehaviorSubject<int> dynamicLickStream = BehaviorSubject<int>();
  bool hasDynamicLink = false;
  Future handleDynamicLinks() async {
    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    await _handleDeepLink(data);

    /// from background into foreground

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) {
          _handleDeepLink(dynamicLinkData);
        },
        onError: (OnLinkErrorException e) async {});
  }

  _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      // print(data.link.queryParameters);
      var id;
      if (data.link.queryParameters.containsKey("id")) {
        id = int.parse(data.link.queryParameters['id']);
        hasDynamicLink = true;
        dynamicLickStream.add(id);
      }
    }
  }

  Future<String> createTrackDynamicLink({Track track}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://app.goodvibesofficial.com/dlink',
        link:
        Uri.parse('''https://goodvibesofficial.com/track?id=${track.id}'''),
        androidParameters: AndroidParameters(
          packageName: 'com.goodvibes',
        ),
        iosParameters: IosParameters(
          bundleId: 'com.Clickandpressllc.GoodVibes',
          appStoreId: '1454917657',
          minimumVersion: '2.2.15',
          customScheme: 'dynamic link',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: track.title,
          imageUrl: Uri.parse(track.image),
          description: track.description,
        ));

    var shortlink = await parameters.buildShortLink();

    return shortlink.shortUrl.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/theme.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/utils/strings/ads_ids_strings.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:rxdart/subjects.dart';
import "../../services/connectivity_service.dart";
import '../mini_player.dart';
import "common_widgets_methods.dart";

class PagesWrapperWithBackground extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool hasScaffold;
  final Widget appbar;
  final bool showBannerAds;
  final double customPaddingHoz;
  final Widget miniPlayer;
  final bool showMiniPlayer;

  final String bgImage;
  PagesWrapperWithBackground({
    @required this.child,
    this.color,
    this.hasScaffold = false,
    this.appbar,
    this.customPaddingHoz,
    this.showBannerAds = false,
    this.miniPlayer,
    this.showMiniPlayer = true,
    this.bgImage = another_background,
  });

  @override
  _PagesWrapperWithBackgroundState createState() =>
      _PagesWrapperWithBackgroundState();
}

class _PagesWrapperWithBackgroundState extends State<PagesWrapperWithBackground>
    with WidgetsBindingObserver {
  bool _showBannerAds;

  NativeAdmobController _nativeAdmobController = NativeAdmobController();
  double _height = 0.0;
  final _userPaidStatus = locator<UserService>()?.user?.value?.paid ?? false;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    checkConnectionStatus();
    _showBannerAds = widget.showBannerAds;
    if (widget.showBannerAds && !_userPaidStatus) {
      _nativeAdmobController?.reloadAd(forceRefresh: true);
      _nativeAdmobController?.stateChanged?.listen((event) {
        if (event == AdLoadState.loadCompleted) {
          if (mounted) {
            setState(() {
              _height = 50.0;
            });
          }
        }
      });
    }

    WidgetsBinding.instance.addObserver(this);
  }

  checkConnectionStatus() async {
    _isOffline = await checkIfOffline();

    if (_isOffline) {
      locator<ConnectivityService>().appConnectionStatus.value =
      _isOffline ? ConnectivityStatus.Offline : ConnectivityStatus.WiFi;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _nativeAdmobController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      setState(() {
        _showBannerAds = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _showBannerAds = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);

    AppConfig().init(context);
    if (Theme.of(context).textTheme.headline1.fontSize == 0.0 ||
        Theme.of(context).textTheme.headline1.fontSize == 112.0) {
      locator<BehaviorSubject<ThemeData>>().add(getCustomTheme(context));
    }
    Widget _buildBodyWithPadding() {
      var padding = widget.customPaddingHoz ?? symmetricHorizonatalPadding;
      return Scaffold(
        backgroundColor: tpt,
        floatingActionButton: widget.showMiniPlayer ? MiniPlayer() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: widget.child,
        ),
      );
    }

    return Container(
      height: sizeManager.hp(100),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.bgImage),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: widget.hasScaffold
                ? Scaffold(
              bottomNavigationBar:
              commonOfflineSnackBar(sizeManager.wp(100)),
              appBar: widget.appbar,
              backgroundColor: tpt,
              body: _buildBodyWithPadding(),
            )
                : _buildBodyWithPadding(),
          ),
          if (widget.showBannerAds && !_userPaidStatus)
            Container(
              height: _height,
              child: NativeAdmob(
                adUnitID: getAdsUnitID,
                controller: _nativeAdmobController,
                loading: Container(),
                options: getNativeAdmobOption,
                type: NativeAdmobType.banner,
              ),
            ),
        ],
      ),
    );
  }
}

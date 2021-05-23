import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:goodvibesoffl/locator.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/services/connectivity_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class MusicPlayerPageFavIcon extends StatefulWidget {
  final Track track;
  MusicPlayerPageFavIcon({this.track});

  @override
  _MusicPlayerPageFavIconState createState() => _MusicPlayerPageFavIconState();
}

class _MusicPlayerPageFavIconState extends State<MusicPlayerPageFavIcon> {
  bool isTrackFavourite = false;
  bool isBusy = false;
  final _locator = locator<MusicService>();
  @override
  void initState() {
    super.initState();
    checkFav();
  }

  checkFav() async {
    bool fav;

    fav = await _locator.isFavTrack();
    // var isFav = _locator.isFav.value;

    setState(() {
      //  var isFav = _locator.isFav.value;

      isTrackFavourite = fav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    return StreamBuilder<ConnectivityStatus>(
        stream: ConnectivityService().connectionStatusController.stream,
        initialData: Provider.of<ConnectivityStatus>(context),
        builder: (context, connectionStatus) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                height: (AppConfig.isTablet
                    ? sizeManager.wp(8)
                    : sizeManager.wp(12.16)),
                width: (AppConfig.isTablet
                    ? sizeManager.wp(8)
                    : sizeManager.wp(12.16)),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: whiteColor.withOpacity(0.2)),
                child: isBusy
                    ? SpinKitCircle(
                  color: whiteColor,
                  size: AppConfig.isTablet
                      ? sizeManager.scale(20)
                      : sizeManager.scale(30),
                )
                    : InkWell(
                  onTap: () async {
                    if (connectionStatus.data ==
                        ConnectivityStatus.Offline) {
                      showOfflineSnackBar(context: context);
                      return;
                    }
                    setState(() {
                      isBusy = true;
                    });
                    if (!isTrackFavourite) {
                      await _locator.implementFavourite(
                          _locator.currentTrack.value);
                      setState(() {
                        isTrackFavourite = true;
                      });
                    } else {
                      await _locator
                          .deletFav(_locator.currentTrack.value);

                      setState(() {
                        isTrackFavourite = false;
                      });
                    }
                    setState(() {
                      isBusy = false;
                    });
                  },
                  child: Icon(
                    _locator.isFav.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: AppConfig.isTablet
                        ? sizeManager.wp(4)
                        : sizeManager.wp(7.29),
                    color: _locator.isFav.value
                        ? Color(0xff3D72DE)
                        : whiteColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

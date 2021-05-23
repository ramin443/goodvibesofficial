import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:goodvibesoffl/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodvibesoffl/bloc/common_bloc/common_event.dart';
import 'package:goodvibesoffl/bloc/composer/composer_bloc.dart';
import 'package:goodvibesoffl/bloc/downloadpage/downloadpage_bloc.dart';
import 'package:goodvibesoffl/bloc/dynamic_homepage/dynamichomepagewidget_bloc.dart';
import 'package:goodvibesoffl/bloc/homepage_count.dart/homepage_count_bloc.dart';
import 'package:goodvibesoffl/bloc/profile_page_bloc/profilepage_bloc.dart';
import 'package:goodvibesoffl/bloc/rituals/rituals_bloc.dart';
import 'package:goodvibesoffl/bloc/settings/settings_bloc.dart';
import 'package:goodvibesoffl/models/composer_download_task_model.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/screens/home/widgets/common_widgets.dart';
import 'package:goodvibesoffl/screens/rituals/rituals_home.dart';
import 'package:goodvibesoffl/providers/rituals_provider.dart';
import 'package:goodvibesoffl/services/composer_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import 'package:goodvibesoffl/services/navigation_service.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';
import 'package:goodvibesoffl/widgets/common_widgets/common_widgets_methods.dart';
import 'package:goodvibesoffl/widgets/mini_player.dart';
import 'package:goodvibesoffl/bloc/common_bloc/common_state.dart' as cm;

import '../../locator.dart';
import 'composer/composer_control.dart';
//import 'dynamiac_home_page_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import '../widgets/widgets.dart';

class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  ReceivePort _port = ReceivePort();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final musicLocator = locator<MusicService>();
  final composerService = locator<ComposerService>();
  ScrollController _controller = ScrollController();
  bool letsMeditateLoaded = true,
      recommandedLoaded = true,
      dynamicHpageContentLoaded = true,
      ritualsLoaded = true;

  RitualsProvider _ritualsProvider = RitualsProvider();

  _addBlocEvents() {
    BlocProvider.of<SettingsBloc>(context).add(FetchSettings());

    BlocProvider.of<ProfilepageBloc>(context).add(ProfileFetchData());
  }

  _addPullToRefreshEvents() {
    dynamicHpageContentLoaded = false;
    ritualsLoaded = false;

    BlocProvider.of<RitualsBloc>(context).add(RefreshRitualsPlaylist());
    BlocProvider.of<HomepageCountBloc>(context).add(FetchConfigEvent());
    BlocProvider.of<DynamichomepagewidgetBloc>(context).add(RefreshItems());
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (locator<IsInitizalise>().isInitialize ==
        NotifInitializationStatus.UNINITIALIZED) {
      bindBackgroundIsolate();
      FlutterDownloader.registerCallback(downloadCallback);
      _configureSelectNotificationSubject();
    } else if (locator<IsInitizalise>().isInitialize ==
        NotifInitializationStatus.PATRIALINITIALIZED) {
      _configureSelectNotificationSubject();
    }

    _addBlocEvents();

    // _controller.addListener(() {
    //   if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
    //     BlocProvider.of<HomepageCountBloc>(context).add(FetchConfigEvent());
    //   }
    // });

    /// listening to composer item download complete stream and calling bloc's event
    /// from hompage, becasue homepage is never disposed and it's context is also not removed
    /// when user navigatest to other pages while composer items are being downloaded
    composerService.lastDownloadedItemController.stream.listen((id) =>
        BlocProvider.of<ComposerBloc>(context)
            .add(DloadCompleteUpdateComposerItems(trackId: id)));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  void _configureSelectNotificationSubject() {
    locator<BehaviorSubject<String>>().stream.listen((String payload) async {
      locator<IsInitizalise>().isInitialize =
          NotifInitializationStatus.INITIALIZED;

      /// when a notification is opened , another event is fired again with paylod "used event"
      ///  to prevent double navigation return when paylod is that strings
      if (payload.toLowerCase() == "used event") return;

      if (payload != null) {
        if (!_isNumeric(payload)) {
          if (!payload.contains("type"))
            locator<NavigationService>()
                .navigationKey
                .currentState
                .push(CupertinoPageRoute(
                builder: (_) => ComposerControl(
                  isfromBottomSheet: false,
                )));
        }
      }

      if (int.tryParse(payload) != null) {
        if (context == null) return;
        final musicServie = locator<MusicService>();
        int trackID = int.parse(payload);
        Track _currentTrack = musicLocator.getCurrentTrack();
        if (_currentTrack?.id == trackID) {
          musicServie.currentTrack.value = _currentTrack;
          musicServie.trackId.value = _currentTrack.id;
          navigateToMusicPlayer(context, _currentTrack,
              sourcePage: 'downloads page', isFromNotifications: true);
          locator<BehaviorSubject<String>>().add("Used Event");
        } else {
          Track _selectedTrack = await DatabaseService()
              .getSingleDownloadedTrack(trackId: trackID);
          if (_selectedTrack != null) {
            musicServie.currentTrack.value = _selectedTrack;
            musicServie.trackId.value = _selectedTrack.id;
            navigateToMusicPlayer(context, _currentTrack,
                sourcePage: 'downloads page', isFromNotifications: true);
            locator<BehaviorSubject<String>>().add("Used Event");
          }
        }
      }
    });
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    if (!isSuccess) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
      bindBackgroundIsolate();
      return;
    }

    _port.listen((dynamic data) async {
      var _taskId = data[0];
      DownloadTaskStatus _taskStatus = data[1];
      int _progress = data[2];

      if (_progress == -1) {
        musicLocator.downloadPercantage.value = 0;
      }

      musicLocator.downloadPercantage.value = _progress;

      bool _isCopmoserAudioDownload =
      composerService.composerDownloadingTaskIds.contains(_taskId);

      bool _isRitualsPlaylistDownlod =
      RitualsProvider().playlistDownloadingTaskIds.contains(_taskId);

      if (_isCopmoserAudioDownload) {
        await composerService.handleComposerDownload(DownloadTaskModel(
            taskId: _taskId,
            progress: _progress,
            downloadTaskStatus: _taskStatus));
      } else if (_isRitualsPlaylistDownlod) {
        await RitualsProvider().handleDownloadStatus(
          taskId: _taskId,
          status: _taskStatus,
          progress: _progress,
        );
      } else {
        if (_taskStatus == DownloadTaskStatus.complete) {
          musicLocator.isDownloading.value = false;

          musicLocator.isDownloaded.value = true;
          musicLocator.downloadingTrackId = -1;

          DatabaseService()
              .setDownloadComplete(trackID: musicLocator.downloadingTrack.id);

          musicLocator.notifyServerDownloadComplete();
          BlocProvider.of<DownloadpageBloc>(context)
              .add(DownloadPageRefreshTracks());
          musicLocator.downloadPercantage.value = 0;
        } else if (_taskStatus == DownloadTaskStatus.failed) {
          musicLocator.setDownloadingFalse();
          showToastMessage(message: "Download failed");

          musicLocator.isDownloading.value = false;
          musicLocator.isDownloaded.value = false;
          musicLocator.downloadPercantage.value = 0;
          musicLocator.downloadingTrackId = -1;
        }
      }
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  checkAndOffLoading() {
    // letsMeditateLoaded && recommandedLoaded
    if (ritualsLoaded && dynamicHpageContentLoaded) {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);

    return Scaffold(
      floatingActionButton: MiniPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(homepage_bg))),
        child: SafeArea(
          top: true,
          child: SmartRefresher(
            controller: _refreshController,
            header: getMaterialHeader(),
            onRefresh: () {
              _addPullToRefreshEvents();
            },
            child: MultiBlocListener(
              listeners: [
                BlocListener<DynamichomepagewidgetBloc, cm.CommonState>(
                  listener: (context, state) {
                    if (!(state is cm.RefreshingState)) {
                      dynamicHpageContentLoaded = true;
                    }
                    checkAndOffLoading();
                  },
                ),
                BlocListener<RitualsBloc, RitualsState>(
                  listener: (context, state) {
                    if (!(state is RefreshRitualsPlaylist)) {
                      ritualsLoaded = true;
                    }
                    checkAndOffLoading();
                  },
                ),
              ],
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setHeight(30)),
                  //  HomePageHeader(width: width),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          RitualsHome(),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                        //  Flexible(child: DynamicHomePageWidget()),
                          SizedBox(height: 100.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

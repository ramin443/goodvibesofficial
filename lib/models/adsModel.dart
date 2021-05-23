import 'package:goodvibesoffl/routes.dart';

class AdsModel {
  int _singlePlayerAdCount;
  bool _bannerAd;
  bool _rewardAd;
  bool _interstitialAd;
  bool _homepage;
  bool _profile;
  bool _history;
  bool _favorite;
  bool _downloads;
  bool _setting;
  bool _editAccount;
  bool _changePassword;
  bool _subscribtionDetail;
  bool _notification;
  bool _recentUpdatedTracks;
  bool _genresongs;
  bool _reminderPage;
  bool _deleteReminder;
  bool _setReminder;
  bool _singlePlayer;
  bool _notificationSetting;
  bool _playlist;
  bool _allAchievementPage;
  AdsModel({
    bool bannerAd = true,
    bool rewardAd = true,
    bool interstitialAd = true,
    bool homepage = true,
    bool profile = true,
    bool history = true,
    bool favorite = true,
    bool downloads = true,
    bool setting = true,
    bool editAccount = true,
    bool changePassword = true,
    bool subscribtionDetail = true,
    bool notification = true,
    bool recentUpdatedTracks = true,
    bool genresongs = true,
    bool reminderPage = true,
    bool deleteReminder = true,
    bool setReminder = true,
    bool singlePlayer = true,
    bool playlist = true,
    bool notificationSetting = true,
    bool allAchievementPage = true,
    int singlePlayerAdCcount = 3,
  })  : _bannerAd = bannerAd,
        _deleteReminder = deleteReminder,
        _downloads = downloads,
        _editAccount = editAccount,
        _favorite = favorite,
        _genresongs = genresongs,
        _history = history,
        _homepage = homepage,
        _interstitialAd = interstitialAd,
        _notification = notification,
        _profile = profile,
        _recentUpdatedTracks = recentUpdatedTracks,
        _reminderPage = reminderPage,
        _rewardAd = rewardAd,
        _setReminder = setReminder,
        _setting = setting,
        _subscribtionDetail = subscribtionDetail,
        _changePassword = changePassword,
        _singlePlayer = singlePlayer,
        _playlist = playlist,
        _notificationSetting = notificationSetting,
        _allAchievementPage = allAchievementPage,
        _singlePlayerAdCount = singlePlayerAdCcount;

  static bool getBoolFromObject(Map<String, dynamic> item, String key) {
    if (!item.containsKey(key))
      return true;
    else {
      final temp = item[key];
      if (temp == null) return true;
      return temp as bool;
    }
  }

  static bool getSecondaryBoolFromObject(
      Map<String, dynamic> item, String key) {
    if (!item.containsKey("pages")) return true;
    if (!item["pages"].containsKey(key))
      return true;
    else {
      final temp = item["pages"][key];
      if (temp == null) return true;
      return temp as bool;
    }
  }

  factory AdsModel.fromJson(Map<String, dynamic> item) {
    return AdsModel(
        bannerAd: getBoolFromObject(item, "banner"),
        rewardAd: getBoolFromObject(item, 'reward'),
        interstitialAd: getBoolFromObject(item, 'interstitial'),
        changePassword: getSecondaryBoolFromObject(item, change_password_page),
        deleteReminder: getSecondaryBoolFromObject(item, delete_reminders_page),
        downloads: getSecondaryBoolFromObject(item, download_page),
        editAccount: getSecondaryBoolFromObject(item, account_settings_page),
        favorite: getSecondaryBoolFromObject(item, favs_page),
        genresongs: getSecondaryBoolFromObject(item, genre_songs_page),
        history: getSecondaryBoolFromObject(item, history_page),
        homepage: getSecondaryBoolFromObject(item, home_page),
        notification: getSecondaryBoolFromObject(item, notification_page),
        profile: getSecondaryBoolFromObject(item, profile_page),
        recentUpdatedTracks: getSecondaryBoolFromObject(item, view_all_page),
        reminderPage: getSecondaryBoolFromObject(item, reminder_page),
        setReminder: getSecondaryBoolFromObject(item, add_new_reminder_page),
        setting: getSecondaryBoolFromObject(item, settings_page),
        subscribtionDetail:
        getSecondaryBoolFromObject(item, subscription_details_page),
        playlist: getSecondaryBoolFromObject(item, playlist_page),
        notificationSetting:
        getSecondaryBoolFromObject(item, notification_settings_page),
        singlePlayer: getSecondaryBoolFromObject(item, single_player),
        allAchievementPage:
        getSecondaryBoolFromObject(item, all_achievement_page),
        singlePlayerAdCcount: item['ad_after_tracks']);
  }

  bool get showRewardAds => _rewardAd;
  bool get showInterstitialAd => _interstitialAd;
  bool get showHomepage => _bannerAd && _homepage;
  bool get showProfile => _bannerAd && _profile;
  bool get showHistory => _bannerAd && _history;
  bool get showFavorite => _bannerAd && _favorite;
  bool get showDownloads => _bannerAd && _downloads;
  bool get showSetting => _bannerAd && _setting;
  bool get showEditAccount => _bannerAd && _editAccount;
  bool get showChangePassword => _bannerAd && _changePassword;
  bool get showSubscribtionDetail => _bannerAd && _subscribtionDetail;
  bool get showNotification => _bannerAd && _notification;
  bool get showRecentUpdatedTracks => _bannerAd && _recentUpdatedTracks;
  bool get showGenresongs => _bannerAd && _genresongs;
  bool get showReminderPage => _bannerAd && _reminderPage;
  bool get showDeleteReminder => _bannerAd && _deleteReminder;
  bool get showSetReminder => _bannerAd && _setReminder;
  bool get showPlaylist => _bannerAd && _playlist;
  bool get showSinglePlayer => _bannerAd && _singlePlayer;
  bool get showNotificationSetting => _bannerAd && _notificationSetting;
  bool get showAllAchievementPage => _bannerAd && _allAchievementPage;
  int get singlePlayerAdCcount => _singlePlayerAdCount;
}

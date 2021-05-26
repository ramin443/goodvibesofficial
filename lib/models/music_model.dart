import 'package:equatable/equatable.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/utils/utils.dart';

class Categories {
  int id, key, gid;
  String name, description;

  Categories({
    this.id,
    this.name,
    this.description,
    this.gid,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'] ?? " ",
      description: json['description'] ?? ' ',
      gid: json['genre_id'],
    );
  }
}

class Genre {
  int id;
  String name, image, thumbnail, description;
  List<Categories> categories;

  Genre({
    this.id,
    this.name,
    this.thumbnail,
    this.image,
    this.categories,
    this.description,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    Genre genre;
    genre = Genre(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['genre_image'] ?? "",
      thumbnail: json['genre_image_standard'] ?? "",
      description: json["description"],
      categories: List<Categories>.from(
          json["categories"].map((x) => Categories.fromJson(x))),
    );
    genre.categories.insert(0, Categories(id: -1, name: "All"));
    return genre;
  }
}

enum TrackPaidType { Free, Paid, Premium }

TrackPaidType getTrackPaidType(String type) {
  switch (type) {
    case "free":
      return TrackPaidType.Free;
      break;
    case "paid":
      return TrackPaidType.Paid;
      break;
    case "premium":
      return TrackPaidType.Premium;
      break;
    default:
      return TrackPaidType.Free;
  }
}

enum CompletionStatus { Complete, NonStarted, Started }

class Track extends Equatable {
  final int id, cid, gid, playCount, downloadId, downloaded, playlistId;
  final String title,
      filename,
      description,
      url,
      image,
      duration,
      cname,
      gname,
      composer,
      dateTime;
  bool paid;
  Duration lastPlayedDuration;

  // var to track how much of track was played before
  bool saveTrackDuration;

  final String trackDownloadUrl;
  final TrackPaidType trackPaidType;
  final ComposerSavedMix composerMix;
  final PlayablesStat playableStat;
  final bool showTimer;
  final bool unlocked;
  final int unlockDay;
  final DateTime unlockDate;

  Track({
    this.id,
    this.playCount,
    this.title,
    this.gid,
    this.gname,
    this.description,
    this.url,
    this.image,
    this.duration,
    this.cid,
    this.filename,
    this.composer,
    this.cname,
    this.trackDownloadUrl,
    this.downloadId,
    this.dateTime,
    this.downloaded,
    this.paid,
    this.composerMix,
    this.trackPaidType,
    this.saveTrackDuration = false,
    this.playlistId,
    this.lastPlayedDuration = Duration.zero,
    this.playableStat,
    this.showTimer,
    this.unlocked = true,
    this.unlockDay,
    this.unlockDate,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      var _composerMix = json.containsKey("composition")
          ? ComposerSavedMix.fromJson(json['composition'], [])
          : null;
      TrackPaidType trackType = getTrackPaidType(json['track_type'] ?? "");
      var _track = Track(
        id: json['id'],
        cid: json['category'] == null ? 0 : json['category']['id'],
        gid: json['genre'] == null ? 0 : json['genre']['id'],
        title: json['name'],
        playCount: json['play_count'],
        description: json['description'] ?? '',
        url: json['track_url'],
        trackDownloadUrl: json["track_download_url"],
        filename: json['track_name'],
        image: json['track_image'] ?? "",
        duration: json['duration'] ?? " ",
        composer: json['composer_name'] ?? " ",
        cname: json['category'] == null ? ' ' : json['category']['name'] ?? " ",
        gname: json['genre'] == null ? ' ' : json['genre']['name'] ?? " ",
        dateTime: json['datetime'] ?? '',
        paid: json['paid'] ?? true,
        composerMix: _composerMix,
        trackPaidType: trackType,
        playableStat: json['playable_stat'] == null
            ? null
            : PlayablesStat.fromJson(json['playable_stat']),
        showTimer: json['show_timer'] ?? false,
        lastPlayedDuration: json['playable_stat'] != null
            ? getDurationFromDouble(json['playable_stat']['played_duration'])
            : null,
        unlocked: json['unlocked'] == null ? true : json['unlocked'],
        unlockDay: json['unlock_on_day'],
        unlockDate: json['unlock_on_date'] == null
            ? null
            : DateTime.tryParse(json['unlock_on_date']),
      );
      return _track;
    } else {
      return null;
    }
  }

  factory Track.fromDownloadJson(Map<String, dynamic> json) {
    if (json['track'] != null) {
      return Track(
        paid: false,
        id: json['track']['id'],
        cid: json['track']['category_id'] == null
            ? 0
            : json['track']['category_id'],
        gid: json['track']['genre'] == null ? 0 : json['track']['genre']['id'],
        title: json['track']['name'],
        playCount: json['track']['play_count'],
        description: json['track']['description'] ?? '',
        url: json['track']['track_url'],
        trackDownloadUrl: json['track']["track_download_url"],
        filename: json['track']['track_name'],
        downloadId: json['id'] ?? -1,
        image: json['track']['track_image'] ?? "",
        duration: json['track']['duration'] ?? " ",
        composer: json['track']['composer_name'] ?? " ",
        cname: json['track']['category'] == null
            ? ' '
            : json['track']['category']['name'] ?? " ",
        gname: json['track']['genre'] == null
            ? ' '
            : json['track']['genre']['name'] ?? " ",
        dateTime: json['started_at'] ?? '',
        trackPaidType: TrackPaidType.Free,
        showTimer: json['track']['show_timer'] != null
            ? json['track']['show_timer']
            : false,
        unlocked: json['unlocked'] == null ? true : json['unlocked'],
        unlockDay: json['unlock_at_day'],
      );
    }
  }

  factory Track.fromDb(Map<String, dynamic> db) {
    return Track(
      id: db['id'] ?? 0,
      cid: db['cid'] ?? 0,
      title: db['title'] ?? '',
      playCount: db['play_count'] ?? 0,
      description: db['description'] ?? '',
      url: db['url'] ?? '',
      filename: db['filename'] ?? '',
      image: db['image'] ?? "",
      duration: db['duration'] ?? '',
      composer: db['composer'] ?? '',
      cname: db['cname'] ?? '',
      downloadId: db['download_id'] ?? -1,
      dateTime: db['datetime'] ?? '',
      trackDownloadUrl: db['track_download_url'] ?? '',
      downloaded: db['downloaded'] ?? -1,
      paid: db["paid"] == 0 ? false : true,
      trackPaidType: TrackPaidType.Free,
      showTimer:
      db['show_timer'] != null ? getBoolFromInt(db['show_timer']) : false,
    );
  }

  Map<String, dynamic> toJson(Track track) {
    return {
      'id': track.id,
      'title': track.title,
      'duration': track.duration,
      'cid': track.cid,
      'description': track.description,
      'url': track.url,
      'cname': track.cname ?? '',
      'composer': track.composer,
      'image': track.image,
    };
  }

  Track copyWith(
      {int downloadId,
        String downloadUrl,
        String datetime,
        String url,
        int downloaded,
        bool saveTrackDuration,
        Duration lastPlayedDuration,
        int playlistId,
        bool showTimer}) {
    return Track(
      cid: this.cid,
      cname: this.cname,
      paid: this.paid,
      composer: this.composer,
      dateTime: datetime ?? this.dateTime,
      description: this.description,
      downloadId: downloadId ?? this.downloadId,
      downloaded: downloaded ?? this.downloaded,
      duration: this.duration,
      filename: this.filename,
      trackPaidType: this.trackPaidType,
      gid: this.gid,
      gname: this.gname,
      id: this.id,
      image: this.image,
      playCount: this.playCount,
      title: this.title,
      trackDownloadUrl: downloadUrl ?? this.trackDownloadUrl,
      url: url ?? this.url,
      saveTrackDuration: saveTrackDuration,
      playlistId: playlistId ?? this.playlistId,
      lastPlayedDuration: lastPlayedDuration ?? this.lastPlayedDuration,
      playableStat: this.playableStat,
      showTimer: this.showTimer ?? showTimer,
      unlockDate: this.unlockDate,
      unlockDay: this.unlockDay,
      unlocked: this.unlocked,
    );
  }

  static Playablee getTrackPlayable(Track track) {
    return Playablee(
        id: track.id,
        playList: null,
        position: 0,
        track: track,
        type: PlayableType.Track,
        typeID: track.id,
        typeObject: TypeObject(
          description: track.description,
          title: track.title,
          image: track.image,
          dateTime: track.dateTime,
        ),
        stat: track.playableStat);
  }

  @override
  List<Object> get props => [cid, id, cname, url, filename];
}

class HistoryTracks {
  DateTime playedAt;
  Track track;
  HistoryTracks({this.playedAt, this.track});

  factory HistoryTracks.fromJson(Map<String, dynamic> json) {
    String dateTime = json['played_at']
        .toString()
        .toLowerCase()
        .replaceFirst("utc", "")
        .trim();
    return HistoryTracks(
      track: Track.fromJson(json['track']),
      playedAt: DateTime.parse(dateTime),
    );
  }
}

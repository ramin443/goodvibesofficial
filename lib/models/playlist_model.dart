import 'package:goodvibesoffl/models/models.dart';

import 'music_model.dart';
import 'playable_model.dart';

class PlayList {
  int id;
  String title;
  String description;
  String slug;
  String image;
  int playablesCount;
  String imageStandard;
  double totalProgress;
  PlayablesStat playableStat;
  String createdAt;

  int downloadId;

  PlayList({
    this.id,
    this.title,
    this.description,
    this.slug,
    this.image,
    this.playablesCount,
    this.imageStandard,
    this.totalProgress = 0.0,
    this.playableStat,
    this.createdAt,
    this.downloadId,
  });

  PlayList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'] ?? "";
    slug = json['slug'] ?? "";
    image = json['image'] ?? "";
    playablesCount = json['playables_count'];
    imageStandard = json['image_standard'] ?? "";
    createdAt = json['created_at'];
    if (json['playable_stat'] != null) {
      playableStat = PlayablesStat.fromJson(json['playable_stat']);

      totalProgress = (playableStat.totalDuration != 0)
          ? playableStat.playedDuration * 100 / playableStat.totalDuration
          : 0.0;
    }
  }

  factory PlayList.fromDownload(Map map) {
    Map json = map['playlist'];

    PlayablesStat stat = json['playable_stat'] == null
        ? PlayablesStat(
        status: CompletionStatus.NonStarted,
        playedDuration: 0.0,
        totalDuration: 220.0)
        : PlayablesStat.fromJson(json['playable_stat']);

    return PlayList(
      downloadId: map['id'],
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      slug: json['slug'] ?? "",
      image: json['image'] ?? "",
      playablesCount: json['playables_count'],
      imageStandard: json['image_standard'] ?? "",
      totalProgress: (stat.totalDuration != 0)
          ? stat.playedDuration * 100 / stat.totalDuration
          : 0.0,
      playableStat: stat,
      createdAt: map['started_at'],
    );
  }

  factory PlayList.fromRitualDb(Map json) {
    return PlayList(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      slug: json['slug'] ?? "",
      image: json['image'] ?? "",
      playablesCount: json['playables_count'],
      imageStandard: json['image_standard'] ?? "",
      totalProgress: double.parse(json["total_progress"].toString()) ?? 0.0,
      playableStat: PlayablesStat(
          status: json['played_duration'] == 0.0
              ? CompletionStatus.NonStarted
              : CompletionStatus.Started,
          playedDuration: json['played_duration'],
          totalDuration: json['total_duration']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['playables_count'] = this.playablesCount;
    data['image_standard'] = this.imageStandard;
    return data;
  }

  PlayList copyWith({PlayablesStat stat, double totalProgress}) {
    return PlayList(
      id: this.id,
      title: this.title,
      description: this.description,
      slug: this.slug,
      image: this.image,
      playablesCount: this.playablesCount,
      imageStandard: this.imageStandard,
      totalProgress: totalProgress ?? this.totalProgress,
      playableStat: stat ?? this.playableStat,
    );
  }

  static Playable getPlaylistPlayable(PlayList playlist) {
    return Playable(
        id: playlist.id,
        playList: playlist,
        track: null,
        typeID: playlist.id,
        stat: playlist.playableStat,
        type: PlayableType.Playlist,
        typeObject: TypeObject(
          title: playlist.title,
          description: playlist.description,
          image: playlist.image,
          dateTime: playlist.createdAt,
        ));
  }
}

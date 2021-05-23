import 'package:goodvibesoffl/models/models.dart';
import 'package:goodvibesoffl/models/playable_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';

import 'music_model.dart';

class DownloadPlayable {
  final Track track;
  final PlayList playList;
  final PlayableType type;
  const DownloadPlayable({this.track, this.playList, this.type});

  factory DownloadPlayable.fromJson(Map json) {
    return DownloadPlayable(
      track: json['track'] == null ? null : Track.fromDownloadJson(json),
      playList: json['playlist'] == null ? null : PlayList.fromDownload(json),
      type: json['track'] == null ? PlayableType.Track : PlayableType.Playlist,
    );
  }
}

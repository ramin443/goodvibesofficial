import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';

enum PlayableType { Track, Playlist, Rituals }

PlayableType getPlayableType(type) {
  if (type.toLowerCase() == 'playlist') {
    return PlayableType.Playlist;
  } else if (type.toLowerCase() == 'track') {
    return PlayableType.Track;
  } else if (type.toLowerCase() == 'ritual') {
    return PlayableType.Rituals;
  }
}

class Playablee {
  int id;
  PlayableType type;
  int typeID;
  int position;
  Track track;
  PlayList playList;
  TypeObject typeObject;
  PlayablesStat stat;

  Playablee({
    this.id,
    this.playList,
    this.position,
    this.track,
    this.type,
    this.typeID,
    this.typeObject,
    this.stat,
  });

  factory Playablee.fromJson(Map<String, dynamic> playable) {
    PlayableType type = getPlayableType(playable['type'].toString());
    if (type == PlayableType.Playlist || type == PlayableType.Rituals) {
      return Playablee(
        id: playable["id"],
        playList: PlayList.fromJson(playable['type_object']),
        position: playable['position'],
        track: null,
        type: type,
        typeID: playable['type_id'],
        typeObject: TypeObject.fromJson(playable['type_object']),
        stat: playable['playable_stat'] != null
            ? PlayablesStat.fromJson(playable['playable_stat'])
            : null,
      );
    } else {
      return Playablee(
        id: playable["id"],
        playList: null,
        position: playable['position'],
        track: playable['type_object'] != null
            ? Track.fromJson(playable['type_object'])
            : null,
        type: type,
        typeID: playable['type_id'],
        typeObject: playable['type_object'] == null
            ? null
            : TypeObject.fromJson(playable['type_object']),
        stat: playable['playable_stat'] != null
            ? PlayablesStat.fromJson(playable['playable_stat'])
            : null,
      );
    }
  }

  Playablee copywith({Track track, PlayList playlist}) {
    return Playablee(
      id: this.id,
      playList: playlist ?? this.playList,
      position: this.position,
      track: track ?? this.track,
      type: this.type,
      typeID: this.typeID,
      typeObject: this.typeObject,
      stat: this.stat,
    );
  }
}

class TypeObject {
  final String image, title, description, dateTime;

  const TypeObject({this.image, this.title, this.description, this.dateTime});

  factory TypeObject.fromJson(Map json) {
    return TypeObject(
        image: json['image'],
        title: json['name'],
        description: json['description'],
        dateTime: '');
  }
}

CompletionStatus getCompletionStatus(String status) {
  status = status.toLowerCase();

  if (status == 'inprogress') {
    return CompletionStatus.Started;
  } else if (status == 'completed') {
    return CompletionStatus.Complete;
  } else if (status == 'not_started') {
    return CompletionStatus.NonStarted;
  }
}

class PlayablesStat {
  final int id;
  final CompletionStatus status;
  final totalDuration;
  final playedDuration;
  final DateTime startedAt;

  const PlayablesStat(
      {this.id,
        this.status,
        this.totalDuration,
        this.playedDuration,
        this.startedAt});

  factory PlayablesStat.fromJson(Map json) {
    return PlayablesStat(
        id: json['id'],
        playedDuration: json['played_duration'],
        status: json['status'] == null
            ? CompletionStatus.NonStarted
            : getCompletionStatus(
          json['status'],
        ),
        totalDuration: json['total_duration'],
        startedAt: json['started_at_unix'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
            json['started_at_unix'] * 1000)
            : null);
  }
}

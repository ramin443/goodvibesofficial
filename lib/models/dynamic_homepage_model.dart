import 'playable_model.dart';

enum DynamicDataType { PLAYLIST, TRACK, RITUALS }
DynamicDataType getDynamicDataType(type) {
  if (type.toLowerCase() == 'playlist') {
    return DynamicDataType.PLAYLIST;
  } else if (type.toLowerCase() == 'track') {
    return DynamicDataType.TRACK;
  } else if (type.toLowerCase() == 'ritual') {
    return DynamicDataType.RITUALS;
  }
}

class HomepageDynamicData {
  int id;
  DynamicDataType type;
  int position;
  PlayablesStat stat;
  TypeObject typeObject;
  List<Playable> playables;

  HomepageDynamicData({
    this.id,
    this.type,
    this.position,
    this.typeObject,
    this.playables,
    this.stat,
  });

  factory HomepageDynamicData.fromJson(Map<String, dynamic> json) {
    DynamicDataType playableType = getDynamicDataType(json['type']);

    var playables = List<Playable>.from(json["playables"] == null
        ? []
        : json["playables"].map(
          (a) => Playable.fromJson(a),
    ));

    for (int i = 0; i < playables.length; i++) {
      var item = playables[i];
      if (item.type == PlayableType.Track && item.track == null) {
        playables.remove(item);
      }
    }

    return HomepageDynamicData(
      id: json["id"],
      type: playableType,
      typeObject: TypeObject.fromJson(json["type_object"]),
      playables: playables,
      stat: json['playable_stat'] == null
          ? null
          : PlayablesStat.fromJson(json['playable_stat']),
    );
  }
}

class TypeObject {
  int id;
  String title;
  String description;
  String slug;
  String image;
  int playablesCount;
  String imageStandard;
  TypeObject(
      {this.id,
        this.title,
        this.description,
        this.slug,
        this.image,
        this.imageStandard,
        this.playablesCount});

  factory TypeObject.fromJson(Map<String, dynamic> json) {
    return TypeObject(
      id: json['id'],
      title: json["title"],
      description: json["description"],
      slug: json["slug"],
      image: json["image"],
      playablesCount: json["playables_count"],
      imageStandard: json["image_standard"],
    );
  }
}

// class Playable {
//   int id;
//   DynamicDataType type;
//   int typeId;
//   Track track;
//   PlayList playlist;
//   int position;
//   Playable(
//       {this.id,
//       this.type,
//       this.typeId,
//       this.track,
//       this.playlist,
//       this.position});

//   factory Playable.fromJson(Map<String, dynamic> json) {
//     DynamicDataType type = json["type"] == "Playlist"
//         ? DynamicDataType.PLAYLIST
//         : DynamicDataType.TRACK;

//     if (type == DynamicDataType.PLAYLIST)
//       return Playable(
//           id: json["id"],
//           type: json["type"] == "Playlist"
//               ? DynamicDataType.PLAYLIST
//               : DynamicDataType.TRACK,
//           position: json["position"],
//           track: null,
//           playlist: PlayList.fromJson(json["type_object"]));
//     else
//       return Playable(
//         id: json["id"],
//         type: json["type"] == "Playlist"
//             ? DynamicDataType.PLAYLIST
//             : DynamicDataType.TRACK,
//         position: json["position"],
//         playlist: null,
//         track: Track.fromJson(json["type_object"]),
//       );
//   }
// }

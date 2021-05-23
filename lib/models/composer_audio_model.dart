import 'package:flutter/material.dart';
import 'package:goodvibesoffl/services/composer_service.dart';

import '../locator.dart';
import "../models/playable_model.dart" as P;
import '../utils/strings/audio_constants.dart';
import './dynamic_homepage_model.dart';
import './music_model.dart';

class ComposerAudio {
  final int id;
  final String url;
  final String downloadUrl;
  final String audioTitle;
  final double defaultVolume;
  final String composerType;
  final String audioPathType;
  final String fileName;

  final String image;
  final bool isPaid;
  final int categoryId;
  final String category;

  ComposerCategory categoryObj;

  //  == "file" or "asset"
  bool isPlaying;

  /// primary constructor for [ComposerAudio]
  ComposerAudio({
    this.id,
    this.audioTitle,
    this.defaultVolume,
    this.isPlaying,
    this.composerType,
    this.categoryObj,
    this.audioPathType,
    this.image,
    this.isPaid,
    this.category,
    this.categoryId,
    this.fileName,
    this.url,
    this.downloadUrl,
  });

  /// this constructor is used if , composer item have to be downloaded if they are not
  /// in assets or local files
  factory ComposerAudio.fromPlayable(
      {P.Playable playable,
        HomepageDynamicData data,
        List<String> localFilesList}) {
    Track track = playable.track;

    var _audioPathType = getAudioFileType(
        fileName: track.filename,
        //localFilesList: //localFilesList,
        id: track.id,
        url: track.url,
        audioTitle: track.title,
        downloadUrl: track.trackDownloadUrl,
        shouldDownload: true);

    return ComposerAudio(
        id: track.id,
        url: track.url,
        audioTitle: track.title,
        fileName: track.filename,
        composerType: data.typeObject.title,
        isPaid: track.paid ?? false,
        image: track.image,
        defaultVolume: 0.5,
        category: data.typeObject.title,
        categoryId: data.id,
        audioPathType: _audioPathType,
        downloadUrl: track.trackDownloadUrl);
  }

  ComposerAudio copyWith({
    int id,
    var audioTitle,
    double defaultVolume,
    bool isPlaying,
    var composerType,
    var categoryObj,
    var audioPathType,
    var image,
    bool isPaid,
    var category,
    var categoryId,
    var fileName,
    var url,
    var downloadUrl,
  }) {
    return ComposerAudio(
      id: id ?? this.id,
      audioTitle: audioTitle ?? this.audioTitle,
      defaultVolume: defaultVolume ?? this.defaultVolume,
      isPlaying: isPlaying ?? this.isPlaying,
      composerType: composerType ?? this.composerType,
      categoryObj: categoryObj ?? this.categoryObj,
      audioPathType: audioPathType ?? this.audioPathType,
      image: image ?? this.image,
      isPaid: isPaid ?? this.isPaid,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      fileName: fileName ?? this.fileName,
      url: url ?? this.url,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  //// this constructor is used when the download is not required
  /// the return values from this constructor are probably being user for temporay variables
  ///  in this cons , [shouldDownload] value in  `getAudioFileType` is always false

  factory ComposerAudio.fromPlayableWithOutDownload(
      {P.Playable playable,
        HomepageDynamicData data,
        List<String> localFilesList}) {
    Track track = playable.track;

    var _audioPathType = getAudioFileType(
        fileName: track.filename,
        //localFilesList: //localFilesList,
        id: track.id,
        url: track.url,
        audioTitle: track.title,
        shouldDownload: false);

    return ComposerAudio(
        id: track.id,
        url: track.url,
        audioTitle: track.title,
        fileName: track.filename,
        composerType: data.typeObject.title,
        isPaid: track.paid ?? false,
        image: track.image,
        defaultVolume: 0.5,
        category: data.typeObject.title,
        categoryId: data.id,
        audioPathType: _audioPathType,
        downloadUrl: track.trackDownloadUrl

      // assetsAudioList.contains(track.filename)
      //     ? "AudioType.asset"
      //     : "AudioType.network",
    );
  }

  /// cons to parse json/map from composer items stored in db, without downloading the fiels
  factory ComposerAudio.fromDbWithoutDownload(
      Map<String, dynamic> json, List<String> audioFileList) {
    var _audioPathType = getAudioFileType(
      fileName: json['fileName'],
      url: json['url'],
      //localFilesList: audioFileList,
      audioTitle: json['audioTitle'],
      shouldDownload: false,
    );

    return ComposerAudio(
      id: json['id'],
      url: json['fileName'],
      audioTitle: json['audioTitle'],
      defaultVolume: json['defaultVolume'],
      image: json['image'],
      isPaid: json["paid"] == null ? false : json["paid"] == 1,
      category: json["category"],
      categoryId: json["categoryId"],
      audioPathType: _audioPathType,
      fileName: json['fileName'],
      downloadUrl: json['downloadUrl'],
    );
  }

  //// cons used to parse and added iems to download queue if composer items are not found in assets
  /// or local files
  factory ComposerAudio.fromDb(
      Map<String, dynamic> json, List<String> audioFileList) {
    var _audioPathType = getAudioFileType(
        id: json["id"],
        //localFilesList: audioFileList,
        audioTitle: json['audioTitle'],
        fileName: json['fileName'],
        url: json['url'],
        shouldDownload: true,
        downloadUrl: json['downloadUrl']);

    return ComposerAudio(
      id: json['id'],
      audioTitle: json['audioTitle'],
      defaultVolume: json['defaultVolume'],
      image: json['image'],
      isPaid: json["paid"] == null ? false : json["paid"] == 1,
      category: json["category"],
      categoryId: json["categoryId"],
      audioPathType: _audioPathType,
      fileName: json['fileName'],
      downloadUrl: json['downloadUrl'],
    );
  }

  /// cons to parse json from api
  factory ComposerAudio.fromSavedMixApi(
      Map<String, dynamic> json, List<String> audioFileList) {
    var _audioPathType = getAudioFileType(
      fileName: json['track']['track_name'],
      url: json['url'],
      //localFilesList: audioFileList,
      audioTitle: json['audioTitle'],
      shouldDownload: false,
    );

    return ComposerAudio(
      id: json['track']['id'],
      url: json['track']['track_url'],
      audioTitle: json['track']['name'],
      defaultVolume: json['audio_level'],
      image: json['track']['track_image'],
      isPaid: json['track']["paid"] == null ? false : json["paid"] == 1,
      category: json['track']["category"] == null
          ? "Other"
          : json['track']["category"]['name'],
      categoryId: json['track']["category"] == null
          ? 0
          : json['track']["category"]['id'],
      audioPathType: _audioPathType,
      fileName: json['track']['track_name'],
      downloadUrl: json['track']['track_download_url'],
    );
  }

  /// cons to parse json string drom db for saved mix
  factory ComposerAudio.fromSavedMixDb(
      Map<String, dynamic> json, List<String> localAudioFilesList) {
    return ComposerAudio(
        id: json['id'],
        defaultVolume: json['defaultVolume'],
        url: json['url'],
        downloadUrl: json['downloadUrl'],
        fileName: json['fileName'],
        audioPathType: json['audioPathType'],
        audioTitle: json['audioTitle'],
        category: json['category'],
        isPaid: json['paid'],
        categoryId: json['categoryId'],
        image: json['image']);
  }
}

/// important method to get the audio file type
String getAudioFileType(
    {String fileName,
      // List<String> //localFilesList,
      int id,
      String url,
      String audioTitle,
      String downloadUrl,
      @required shouldDownload}) {
  List<String> assetsList =
      locator<ComposerService>().assetsComposerAudiosList.value;
  List<String> localFilesList =
      locator<ComposerService>().localComposerAudiosList.value;

  String tempFileName = fileName.trim();

  var anotherString = tempFileName;
  if (tempFileName.contains(" ")) {
    anotherString = tempFileName.replaceAll(RegExp(' +'), "%20");
  }

  if (assetsList.contains("assets/audio/" + anotherString)) {
    return audio_asset;
  } else if (localFilesList.contains(fileName)) {
    return audio_file;
  }

  if (shouldDownload)
    locator<ComposerService>().addIntoDownloadQ(ComposerAudio(
        url: url,
        downloadUrl: downloadUrl,
        id: id,
        audioTitle: audioTitle,
        fileName: fileName));

  return audio_network;
}

class ComposerCategory {
  int id;
  String name;

  ComposerCategory({this.id, this.name});
  factory ComposerCategory.fromPlayable({Map<String, dynamic> playable}) {
    return ComposerCategory(
      id: playable['id'],
      name: playable['type_object']['name'],
    );
  }
  factory ComposerCategory.fromDb(Map<String, dynamic> json) {
    return ComposerCategory(id: json['id'], name: json['name']);
  }

  factory ComposerCategory.fromComposerAudio(ComposerAudio audio) {
    return ComposerCategory(id: audio.categoryId, name: audio.category);
  }
}

class ComposerSavedMix {
  final int id;
  final String title;
  final List<ComposerAudio> audios;

  const ComposerSavedMix({this.id, this.title, this.audios});

  factory ComposerSavedMix.fromJson(
      Map<String, dynamic> json, List<String> localAudioFilesList) {
    return ComposerSavedMix(
        id: json['id'],
        title: json['title'],
        audios: json['composition_tracks'] == null
            ? []
            : json['composition_tracks']
            .map<ComposerAudio>((json) =>
            ComposerAudio.fromSavedMixApi(json, localAudioFilesList))
            .toList());
  }

  factory ComposerSavedMix.fromDb(
      {Map<String, dynamic> json,
        int groupId,
        List<String> localAudioFilesList,
        String title}) {
    return ComposerSavedMix(
      id: groupId,
      title: title,
      audios: json['composition']['audios']
          .map<ComposerAudio>((childJson) =>
          ComposerAudio.fromSavedMixDb(childJson, localAudioFilesList))
          .toList(),
    );
  }

  ComposerSavedMix copyWith({
    int id,
    String title,
    List<ComposerAudio> audios,
  }) {
    return ComposerSavedMix(
      id: id ?? this.id,
      title: title ?? this.title,
      audios: audios ?? this.audios,
    );
  }
}

enum CombinedCompostionType { Popular, Recent }

class CombinedCompositions {
  int id;
  String title;
  String subtitle;
  List<ComposerSavedMix> mixes;
  CombinedCompostionType type;
  CombinedCompositions(
      {this.id, this.title, this.subtitle, this.mixes, this.type});

  factory CombinedCompositions.fromJson(
      Map<String, dynamic> json, List<String> localAudioFilesList,
      {String key}) {
    CombinedCompositions _compositions = CombinedCompositions(
        id: -1,
        title: key == "popular" ? "Most Popular" : "Most Recent",
        subtitle: key == "popular"
            ? "Most Popular mixes in our community"
            : "Most Recent mixes in our community",
        mixes: json[key]
            .map<ComposerSavedMix>(
                (e) => ComposerSavedMix.fromJson(e, localAudioFilesList))
            .toList(),
        type: key == "popular"
            ? CombinedCompostionType.Popular
            : CombinedCompostionType.Recent);

    if (_compositions.mixes.isEmpty) {
      return null;
    } else {
      for (int i = 0; i < _compositions.mixes.length; i++) {
        var mixItem = _compositions.mixes[i];
        if (mixItem.audios.isEmpty) {
          _compositions.mixes.remove(mixItem);
        }
      }
    }
    return _compositions;
  }
}

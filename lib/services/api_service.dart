import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_inapp_purchase/modules.dart';
//import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:goodvibesoffl/config.dart';
import 'package:goodvibesoffl/models/composer_audio_model.dart';
import 'package:goodvibesoffl/services/session_service.dart';
import 'package:goodvibesoffl/services/user_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:goodvibesoffl/services/shared_pref_service.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../locator.dart';
import "package:dio_firebase_performance/dio_firebase_performance.dart";

class ApiService {
  Dio _dio = Dio();

  final sessionService = SessionService();

  static const success_key = 'success';
  static const authorization_key = "Authorization";

  final List<String> _nonCachhableEndpoints = [];

  /// funnction which returns map for authorization header
  getAuthorization() {
  //  var tokenFromLocator = locator<UserService>().user.value.authToken;

    ////// //print('token from locator: $tokenFromLocator');
    return {"Authorization": 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozNzQ2N30.mMqJz0UBU6RnV6MtsvpEb0elFan3-iuK6awoFt5zN5I'};
  }

  getAuthorizationWithSessionId() {
  //  var token = locator<UserService>().user.value.authToken;
    var sessionId = sessionService.sessionId;
    print("session id is: $sessionId");

    // //print(token);
    return
         {authorization_key: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3MTI2Mn0.D8kypb9nfxIK8FAYjkuJWhbDv4ziPpWe7Z9NPSeeO_c'};
  }

//// map of cancel tokens for canceling http requests
  final Map<String, dynamic> cancelTokens = {};

//// music and album related methods

  setDeviceToken({
    String token,
    String platform,
    String uid,
    String manufacture,
    String version,
  }) async {
    final url = "$baseUrl/devices";
    var response = await postRequest(
        url: url,
        data: {
          "token": token,
          "platform": platform,
          "version": version,
          "name": manufacture,
          "udid": uid
        },
        options: Options(
          headers: getAuthorization(),
        ));
    // //print(response);
  }

  getSingleTrack(var id) async {
    final url = '$baseUrl/tracks/$id';

    var response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    // //log.i(response);
    return response;
  }

  getTracksByGenreCategory(
      {int categoryId, int genreId, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks';

    //// //print(' get tracks by category:');
    var response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest,
      url: url,
      queryParameters: {"category_id": categoryId},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    // //log.i(response);
    return response;
  }

  getCategoryTracks(
      {int id, int page, int perpage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks';

    var response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'category_id': id, 'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getAlbumsTracks(
      {int id, int page, int perpage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'album_id': id, 'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  gettrending({int page, int perpage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks/popular';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getRecentTracks(
      {int page, int perpage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getUsersRecomendTracks({bool isRefreshRequest = false}) async {
    //  return {"data": []};

    final url = '$baseUrl/tracks/tag_recommended';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': 1, 'per_page': 10},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  getAlbums({int page, int perpage, bool isRefreshRequest = false}) async {
    /// TODO:change url
    final url = '$baseUrl/playlists';
    //   final url = '$baseUrl/tracks';
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getGenre({bool isRefreshRequest = false}) async {
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: '$baseUrl/genres',
      queryParameters: {"page": 1, "per_page": 20},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getGenreTracks(
      {int id, int page, int perpage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks';
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest,
      url: url,
      queryParameters: {'genre_id': id, 'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    //  //log.i(response);

    return response;
  }

  getGenreCategory(
      {int id, int perpage, int page, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/categories';
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': page, 'per_page': perpage, 'genre_id': id},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  Future getSearchDetails(
      {String text,
        int page,
        int perPage,
        bool isRefreshRequest = false}) async {
    //final url = '$baseUrl/tracks/search';
    final url = "$baseUrl/tracks";
    //// //print(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'search': text, "page": page, "per_page": perPage},
      options: Options(headers: getAuthorizationWithSessionId()),
    );

    //log.i(response);

    return response;
  }

  getPopularTracks(
      {int page, int perPage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/tracks/popular';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': page, 'per_page': perPage},
      options: Options(headers: getAuthorizationWithSessionId()),
    );

    return response;
  }

  getHomepageMeditatePlayable({bool isRefreshRequest = false}) async {
    final url = "$baseUrl/playables/lets_meditate";
    final Map response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {"page": 1, "per_page": 10},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  Future<Map<String, dynamic>> getDownloads(
      {int page, int perpage, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/downloads';
    //// //print(url);
    _nonCachhableEndpoints.add(url);
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {'page': page, 'per_page': perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    ////log.i(response);

    return response;
  }

  getComposeItems() async {
    //return {"data": somedata};

    final url = "$baseUrl/playables/composer";
    _nonCachhableEndpoints.add(url);
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        queryParameters: {"preload": true, "preload_count": 100},
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  getUsersSavedComposerMixes(
      {int userId, bool isRefreshRequest = false}) async {
    final url = "$baseUrl/composer/mixes";
    _nonCachhableEndpoints.add(url);
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        isRefreshRequest: isRefreshRequest ?? false,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));

    return response;
  }

  savecomposerMix({List<ComposerAudio> audios, String title}) async {
    final url = "$baseUrl/compositions";

    var body = {
      "composition": {
        "title": title,
        "composition_tracks_attributes": List.generate(
            audios.length,
                (index) => {
              "track_id": audios[index].id,
              "audio_level": audios[index].defaultVolume,
              "position": index
            })
      }
    };

    final response = await postRequest(
      url: url,
      data: body,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  updateComposerMixPlayCount({int id}) async {
    final url = "$baseUrl/compositions/$id/played";

    //print("|update play count called : $url");
    try {
      final response =
      await Dio(BaseOptions(receiveDataWhenStatusError: true)).put(
        url,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ),
      );

      if (response.statusCode == 200) {
        return {"data": response.data};
      }
    } on DioError catch (e) {
      var error = e.response.data;
      return {"error": error ?? "error"};
    }
  }

  deleteSavedMix({int id}) async {
    final url = "$baseUrl/compositions/$id";

    try {
      final response = await Dio(BaseOptions(receiveDataWhenStatusError: true))
          .delete(url,
          options: Options(headers: getAuthorizationWithSessionId()));

      if (response.statusCode == 200) {
        return {"data": response.data};
      }
    } on DioError catch (e) {
      //print(e);
      return {"error": e.response.data};
    }
  }

  updateSavedMix({int id, String title, List<ComposerAudio> audios}) async {
    final url = "$baseUrl/compositions/$id";

    var body = {
      "composition": {
        "title": title,
        "composition_tracks_attributes": List.generate(
            audios.length,
                (index) => {
              "track_id": audios[index].id,
              "audio_level": audios[index].defaultVolume,
              "position": index
            })
      }
    };

    try {
      final response = await Dio().put(
        url,
        data: body,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ),
      );
      if (response.statusCode == 200) {
        return {"data": response.data};
      }
    } on DioError catch (e) {
      return {"errror": e.response.data};
    }
  }

  getSavedComposerMixes({bool isRefreshRequest = false}) async {
    final url = "$baseUrl/compositions";
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        isRefreshRequest: isRefreshRequest ?? false,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  getRecentCompositions({bool isRefreshRequest = false}) async {
    final url = "$baseUrl/compositions/published";

    final Map response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        isRefreshRequest: isRefreshRequest ?? false,
        url: url,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));

    return response;
  }

  getPopularCompositions({bool isRefreshRequest = false}) async {
    final url = "$baseUrl/compositions/popular";

    final Map response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        isRefreshRequest: isRefreshRequest ?? false,
        url: url,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));

    return response;
  }

  getCombinedCompositions({bool isRefreshRequest = false}) async {
    final url = "$baseUrl/compositions/recommended";

    final Map response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        isRefreshRequest: isRefreshRequest ?? false,
        url: url,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));

    return response;
  }

/////---------------tages endpoints

  getWhatBringsYouOptions() async {
    final url = "$baseUrl/tag_groups";

    // //print(getAuthorizationWithSessionId());
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));

    return response;
  }

  postWhatBringsYouHereOptions({List<int> options}) async {
    final url = "$baseUrl/tag_groups";

    final response = await postRequest(
      url: url,
      data: {"tag_group_ids": options},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  getAllRecommendTags() async {
    final url = "$baseUrl/tags";
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  getUserAlreadySelectedTags() async {
    final url = "$baseUrl/taggings";
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  postUserSelectedRecomendTags({List<int> tagIds}) async {
    final url = "$baseUrl/taggings";
    final response = await postRequest(
        url: url,
        data: {"tag_ids": tagIds},
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  deleteUsersRecomendTags(int tagId) async {
    final url = "$baseUrl/taggings/$tagId";
    final response = await Dio().delete(url,
        options: Options(headers: getAuthorizationWithSessionId()));
    if (response.statusCode == 200)
      return {"data": response.data};
    else
      return {"error": " "};
  }

  postUsersRecommedTags(List<int> id) async {
    final url = "$baseUrl/tags";
    final response = await postRequest(
      url: url,
      data: {"id": id},
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    return response;
  }

/////******* track downloading methods*** */
  ///1. first to get download information
  ///2. to download the actual track
  ///3. to cancel dio's download method in 2
  ///4. to notify the server that the download is canceled by user
  //// 5. to notify server that the download is compleeted
  ///

  ///1.
  getDownloadInformation({int trackId, int playlistId}) async {
    var deviceToken = await SharedPrefService().getNotificationToken();

    Map body = {
      "device_platform": Platform.isAndroid ? "android" : "ios",
      "device_token": deviceToken ?? "some_token",
      'playlist_id': playlistId
    };

    if (trackId != null) body['track_id'] = trackId;
    if (playlistId != null) body['playlist_id'] = playlistId;

    Map response = await postRequest(
      url: '$baseUrl/downloads',
      data: body,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    if (playlistId != null) {
      // print(response);
    }

    return response;
  }

//2.
  cancelDioDownload() {
    if (cancelTokens.containsKey(cancel_token)) {
      cancelTokens[cancel_token].cancel('Download cancelled');
    }
  }

  //4.
  cancelDownloadNotifyServer({int trackId, int downloadId}) async {
    final url = '$baseUrl/downloads/$downloadId/cancel';

    var response = await postRequest(
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    //log.i(response);
  }

  ///5. endnpint to notify download complete status
  downloadFinished({int trackId, int downloadId}) async {
    var response = await postRequest(
      url: '$baseUrl/downloads/$downloadId/finish',
      data: {"track_id": trackId},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    //log.i(response);
  }

  /// to delete downlod, required downloadId and trackid
  Future<Map<String, dynamic>> deleteDownload(
      {int trackId, int downloadId}) async {
    var response = await postRequest(
      url: '$baseUrl/downloads/$downloadId/delete',
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

/*favorites related*/

  /// method to add favourite
  addOnFavorite(int trackId) async {
    final response = await postRequest(
      url: '$baseUrl/favourite_tracks/add',
      data: FormData.fromMap({'track_id': trackId}),
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  ///method to remove favourite
  Future<Map<String, dynamic>> removeFromFavorite(int trackId) async {
    final response = await postRequest(
        url: '$baseUrl/favourite_tracks/remove',
        data: FormData.fromMap({'track_id': trackId}),
        options: Options(headers: getAuthorizationWithSessionId()));

    return response;
  }

  /// method to get all favourites
  Future<Map<String, dynamic>> getAllFavorites(
      {bool isRefreshRequest = false}) async {
    //// //print('what');
    //log.i(getAuthorizationWithSessionId());
    final url = '$baseUrl/favourite_tracks';
    _nonCachhableEndpoints.add(url);
    Map response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: '$baseUrl/favourite_tracks',
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  ///  Method to increase play count and add into history
  playTrack({int trackId}) async {
    final url = '$baseUrl/tracks/$trackId/play';
    final response = await postRequest(
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
      data: {},
    );
    //print(response);
  }

  /// method to get play history with date format: 2020-10-10
  getDateWisePlayHistory(
      {String startDate, String endDate, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/play_histories';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {
        "start_date": startDate,
        "end_date": endDate,
      },
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    //log.i(response);
  }

  getAllPlayHistory(
      {int perpage, int page, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/play_histories';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {
        "per_page": perpage,
        "page": page,
      },
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    // log.i(response);
    return response;
  }

  ///------------------------Meditate Method--------------------------------
  getMeditate({int perpage, int page, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/playables/meditation';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {
        "per_page": perpage,
        "page": page,
        "preload": true,
        "preload_count": 4
      },
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    // log.i(response);
    return response;
  }

  getSleep({int perpage, int page, bool isRefreshRequest = false}) async {
    final url = '$baseUrl/playables/sleep';

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {
        "per_page": perpage,
        "page": page,
        "preload": true,
        "preload_count": 4
      },
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getPlaylist(
      {String slug,
        int page,
        int perpage,
        bool isRefreshRequest = false}) async {
    final url = '$baseUrl/playables/$slug';
    // final url = '$baseUrl/tracks';
    // //print(url);
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {"page": page, "per_page": perpage},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getSinglePlaylist(var id, {bool isRefreshRequest = false}) async {
    final url = "$baseUrl/playlists/$id";

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      options: Options(
        headers: getAuthorization(),
      ),
    );
    return response;
  }

  getHomepageDynamicLists(
      {int page, int perpage, bool isRefreshRequest = false}) async {
    //TODO: something
    //  return {"data": []};

    final url = "$baseUrl/playables/home";
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {"preload": true},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  getViewAllOfSpecificItem(
      {String slug,
        int page,
        int perpage,
        bool isRefreshRequest = false}) async {
    final url = "$baseUrl/playables/$slug";
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest ?? false,
      url: url,
      queryParameters: {"page": page, "perpage": perpage},
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    return response;
  }

  getInviteStatus({bool isRefreshRequest = false}) async {
    //  return {"data": []};

    final url = "$baseUrl/invitations";

    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        isRefreshRequest: isRefreshRequest ?? false,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));

    return response;
  }

  postInvitation({String email}) async {
    final url = "$baseUrl/invitations";
    final response = await postRequest(
      url: url,
      data: {"email": email},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  cancelInvitation({int inviteId}) async {
    final url = "$baseUrl/invitations/$inviteId";

    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      final response = await _dio.delete(url,
          options: Options(headers: getAuthorizationWithSessionId()));

      if (response.statusCode == 200) {
        return {"data": response.data};
      }
    } on DioError catch (e) {
      //print("error on cancel invitation: $e");

      return {"error": e.response.data["error"]};
    }
  }

  redeemPromoCode({String code}) async {
    final url = "$baseUrl/promo_codes/redeem";
    final response = await postRequest(
        url: url,
        data: {"code": code},
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  ////----------------------user related methods----------------------------------------------------
  /// method to do both facebook and google login according to the value of provider

  socialLogin({String provider, String accessToken}) async {
    var url = "$baseUrl/login";

    var data = {"provider": provider, "access_token": accessToken};

    final response = await postRequest(url: url, data: data);

    //log.i(response);

    // return {"error": "login error"};
    return response;
  }

  login({String email, String password}) async {
    final url = '$baseUrl/login';

    final Map<String, String> body = {'email': email, 'password': password};
    final response = await postRequest(url: url, data: body);

    return response;
  }

 // signInWithApple(String authorizattionCode,
  //    AuthorizationCredentialAppleID credential) async {
   // final url = "$baseUrl/login";

 //   final response = await postRequest(url: url, data: {
   //   "authorization_code": credential.authorizationCode,
 //     "provider": "apple",
    //  "identity_token": credential.identityToken,
  //    "user_identity": credential.userIdentifier
//    });

  //  return response;
//  }

  signUpUserEmailAndPass(
      {String email, String password, String fullName}) async {
    final url = '$baseUrl/signup';

    final Map<String, String> body = {
      'email': email,
      'password': password,
      "full_name": fullName ?? ""
    };

    Map response = await postRequest(url: url, data: body);

    return response;
  }

  forgotPassword({String email}) async {
    var url = '$baseUrl/password_resets';

    Map response = await postRequest(url: url, data: {"email": email});

    return response;
  }

  confirmEmail(
      {String email, String password, String confirmationToken}) async {
    var url = '$baseUrl/confirmations/$confirmationToken';
    var response = await Dio().put(url, data: {
      "email": email,
      "password": password,
    });
    return response;
  }

  resendEmailConfirmation({@required var email}) async {
    final url = "$baseUrl/confirmations/resend_confirmation";
    final response = await postRequest(
        url: url,
        data: {"email": email},
        options: Options(
          headers: getAuthorization(),
        ));
    return response;
  }

  resetPassword({String oldPassword, String newPassword}) async {
    var url = '$baseUrl/password_resets';
    var response = await Dio().put(url, data: {
      "password": oldPassword,
    });
    return response;
  }

  changePassword({String oldPassword, String newPassword}) async {
    var url = '$baseUrl/users/update_password';
    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      if (oldPassword == null) {
        var response = await _dio.put(
          url,
          data: {
            "new_password": newPassword,
          },
          options: Options(
            headers: getAuthorizationWithSessionId(),
          ),
        );
        return response.data;
      } else {
        var response = await _dio.put(url,
            data: {
              "current_password": oldPassword,
              "new_password": newPassword,
            },
            options: Options(
              headers: getAuthorizationWithSessionId(),
            ));
        return response.data;
      }
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  changeName({String name, Map body}) async {
    var url = '$baseUrl/users/update';
    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      var response = await _dio.put(
        url,
        data: body,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  changeProfileImage({File image}) async {
    var url = '$baseUrl/users/update';
    try {
      Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
      var response = await _dio.put(
        url,
        data: FormData.fromMap(
          {
            "image": await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last),
          },
        ),
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  userSignUp({String email, String uuid}) async {
    final url = '$baseUrl/signup';
    FormData formData = new FormData.fromMap({
      "email": email,
      "uuid": uuid,
    });


    final response = await postRequest(
      url: url,
      data: formData,
    );
    var bearer;
    if (response != null && response.containsKey('data')) {
      bearer = response['data'][auth_token_key];
      await SharedPrefService().setUserToken(bearer);
    }

    return response;
  }

  getCurrentUser({String uid}) async {
    final url = '$baseUrl/users/present_user';
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(
          headers: {'UUID': uid},
        ));

    return response;
  }

  logOutUser({String uid}) async {
    final url = "$baseUrl/logout";

    final response = await postRequest(
        url: url,
        data: {"device_id": uid},
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));
    // //print(response);

    locator<SessionService>().hasSessionIdSet = false;

    return response;
  }

  getSettings() async {
    // //print(getAuthorizationWithSessionId());
    final url = "$baseUrl/settings";

    _nonCachhableEndpoints.add(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    return response;
  }

  updateNotificationSttings(
      {bool dailyUpdates, bool offersPush, bool others, Map body}) async {
    final url = "$baseUrl/settings";
    // //print(getAuthorizationWithSessionId());
    final response = await postRequest(
        url: url,
        data: body,
        options: Options(
          headers: getAuthorizationWithSessionId(),
        ));
    return response;
  }

  postOpenedPushNotification(String id, String deviceToken) async {
    final url = "$baseUrl/push_notifications/$id/open";
    final response = await postRequest(
      url: url,
      data: {"device_token": deviceToken},
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    // //print(response);
    return response;
  }

  getAllNotifications() async {
    final url = "$baseUrl/notifications";
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );

    return response;
  }

  clearAllNotifications() async {
    final url = "$baseUrl/notifications/bulk_clear";
    // //print(url);
    final response = await Dio().delete(
      url,
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    // //print(response);
    return response;
  }

  readSingleNotification(var id) async {
    final url = "$baseUrl/notifications/$id";
    final Map response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  clearANotification(var id) async {
    final url = "$baseUrl/notifications/$id";
    // //print(url);
    final response = await Dio().delete(
      url,
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    // //print(response);
    return response;
  }

  updateUser({Map<String, dynamic> body}) async {
    final url = "$baseUrl/users/update";
    final Map response = await postRequest(
      url: url,
      data: body,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    //print(response);
    return response;
  }

  deactivateUser({String reason}) async {
    final url = "$baseUrl/deactivate";
    final response = await postRequest(
      url: url,
      data: {"reason": reason ?? " "},
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    return response;
  }

  getUserProfileData() async {
    // //print("------------Authorization ID");
    // //print(getAuthorizationWithSessionId());
    final url = "$baseUrl/users/profile";
    _nonCachhableEndpoints.add(url);
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  uploadImageAndUpateUser({String imagePath, String uid}) async {
    final updateUrl = '$baseUrl/users/update_current_user';

    final _formData =
    FormData.fromMap({'image': await MultipartFile.fromFile(imagePath)});

    await _dio.put(
      updateUrl,
      data: _formData,
      options: Options(
        headers: {'UUID': uid},
      ),
    );
  }

  Future<bool> sendMail({String name, String email}) async {
    final url = '$baseUrl/users/user_id/send_mail';

    final _data = FormData.fromMap({'name': name, 'email': email});

    await postRequest(
      url: url,
      data: _data,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return true;
  }

  // get push notifications

  getPushNotifications({int page, int perpage}) async {
    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: '$baseUrl/push_notifications',
      queryParameters: {'page': page, 'per_page': perpage},
      options: Options(
        headers: {'Authorization': getAuthorization()},
      ),
    );

    return response;
  }

  /// method to send subscription info to server
  /// after purchase is complete
 // subscribeUser(
//      {PurchasedItem purchase,
  //      String subscriptionType,
       // String uid,
     //   Map<String, dynamic> bodyData}) async {
   // final url = '$baseUrl/subscriptions';

    //print(url);

   // FormData formData = new FormData.fromMap(
     // {
     //   "purchase_token": purchase.purchaseToken,
   //     "product_id": purchase.productId,
     //   "order_id": purchase.orderId,
        //   "package_name": purchase.skPaymentTransaction.payment.productIdentifier,
   //     "purchase_time": purchase.transactionDate.toString(),
       // "transaction_date": purchase.transactionDate.toString(),
     //   "subs": subscriptionType
   //   },
 //   );

   // var rsp = await postRequest(
 //     url: url,
      //data: bodyData,
    //  options: Options(headers: getAuthorizationWithSessionId()),
  //  );
//
  //  return rsp;
//  }

  getUserSubscriptionDetails() async {
    final url = "$baseUrl/subscriptions";
    _nonCachhableEndpoints.add(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  /// sessions

  getASession() async {}
  getAllSessions() async {}
  getCurrentSession() async {}

  getConfig() async {
    final url = "$baseUrl/config";
    _nonCachhableEndpoints.add(url);
    final Map response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    // //print(response);
    return response;
  }

  Future<Map> getRitualsTracks(int ritualId, {bool isRefreshRequest}) async {
    final url = "$baseUrl/rituals/$ritualId";

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  Future getRitualsPlaylitsts({bool isRefreshRequest}) async {
    final url = "$baseUrl/rituals";

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      isRefreshRequest: isRefreshRequest,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  Future ritualItemPlayed() async {
    final url = "$baseUrl/rituals/played";
    _nonCachhableEndpoints.add(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  getMoreRituals({bool isRefreshRequest}) async {
    final url = "$baseUrl/playables/more_rituals";
    final response = await getRequest(
        nonCachableList: _nonCachhableEndpoints,
        url: url,
        options: Options(headers: getAuthorizationWithSessionId()));
    return response;
  }

  Future downloadRitualCourse() async {
    final url = "$baseUrl/rituals/download";
    _nonCachhableEndpoints.add(url);

    final response = await getRequest(
      nonCachableList: _nonCachhableEndpoints,
      url: url,
      options: Options(
        headers: getAuthorizationWithSessionId(),
      ),
    );
    return response;
  }

  updateRitualTracksDuration(
      int playableStatId, var trackPlayedDuration) async {
    final url = '$baseUrl/playable_stats/$playableStatId/played';
    try {
      final response = await Dio().put(url,
          queryParameters: {'duration': trackPlayedDuration},
          options: Options(
            headers: getAuthorizationWithSessionId(),
          ));
      // print(response);
    } catch (e) {
      // print(e.toString());
    }
  }

  addRitualPlaylistInFavorite(int playlistId) async {
    final _url = '$baseUrl/favourite_playables/add';

    final response = await postRequest(
      url: _url,
      data: {'playlist_id': playlistId},
      options: Options(headers: getAuthorizationWithSessionId()),
    );
    // print(response);
    return response;
  }

  getFavouriteRituals({bool isRefreshRequest = true}) async {
    final _url = '$baseUrl/favourite_playables/playlists';

    final response = await getRequest(
        isRefreshRequest: isRefreshRequest,
        url: _url,
        options: Options(headers: getAuthorizationWithSessionId()));

    return response;
  }

  removeRitualPlaylistFromFavorite(int playlistId) async {
    final _url = '$baseUrl/favourite_playables/remove';

    try {
      final response =
      await Dio(BaseOptions(receiveDataWhenStatusError: true)).delete(_url,
          data: {'playlist_id': playlistId},
          options: Options(
            headers: getAuthorizationWithSessionId(),
          ));

      return response;
    } on DioError catch (e) {
      // print(e.response.data);
    }
  }

  downloadPlaylist(int playlistId, String platform, String token) {
    final url = '$baseUrl/downloads';
    final response = postRequest(
        url: url,
        data: {
          'playlist_id': playlistId,
          'platform': platform,
          'device_token': token
        },
        options: Options(headers: getAuthorizationWithSessionId()));

    return response;
  }
}

Map<String, String> convertMapDynamicToString(Map<String, dynamic> json) {
  Map<String, String> temp = {};

  json.forEach((key, v) {
    temp[key] = v.toString();
  });

  return temp;
}

Future<Map<String, dynamic>> getRequest(
    {var queryParameters,
      @required var url,
      Options options,
      bool isRefreshRequest = false,
      List<String> nonCachableList}) async {
  Map<String, dynamic> httpResponse = {};
  Dio _dio = Dio();
  // print(url);
  recordCrashlyticsLog("get request at $url");

  final _sessionService = locator<SessionService>();

  bool _isUrlNonCachable = false;

  if (nonCachableList != null && !isRefreshRequest) {
    _isUrlNonCachable = nonCachableList.contains(url);
  }

  if (_isUrlNonCachable == false) {
    final tempUri = Uri.https(
        "",
        url,
        queryParameters == null
            ? null
            : convertMapDynamicToString(queryParameters));

    var some = tempUri.toString();
    var urlAddress =
    Uri.parse("https://" + tempUri.toString().split("https://").last);

    final _config = CacheConfig(
      baseUrl: url,
      defaultMaxStale: Duration(days: 2),
      databaseName: "dio-http-cache",
      skipMemoryCache: true,
      defaultMaxAge: Duration(hours: 6),
    );

    final _cacheManager = DioCacheManager(_config);

    final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
    _dio.interceptors.add(firebasePerformanceInterceptor);

    if (isRefreshRequest)
      _cacheManager.deleteByPrimaryKeyWithUri(urlAddress, requestMethod: "GET");

    _dio.interceptors.add(_cacheManager.interceptor);
  }

  try {
    final response = await _dio.get(
      url,
      //options: options,
      options: _isUrlNonCachable
          ? options
          : buildCacheOptions(
        Duration(hours: 6),
        options: options,
        maxStale: Duration(days: 1),
      ),
      queryParameters: queryParameters,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response != null) {
        handleSession(response, _sessionService);

        if (!_isUrlNonCachable) {
          _sessionService.sessionId = null;
          _sessionService.hasSessionIdSet = false;
        }

        if (response.data['success'] == true) {
          httpResponse['data'] = response.data['data'];
          if (response.data.containsKey("page_meta"))
            httpResponse['page_meta'] = response.data["page_meta"];
          if (response.data.containsKey("description"))
            httpResponse['description'] = response.data["description"];
        } else {
          //// //print(response.data["error"]);
          httpResponse["error"] = response.data["error"];
        }
      }

      return httpResponse;
    }
  } on DioError catch (e, stackTrace) {
    //print("error:$e   at url : $url");
 //   Crashlytics.instance.recordError(
   //     'Api get request error at $url \n with message ${e.toString()} ',
     //   stackTrace);

    handleError(e: e.toString(), httpResponse: httpResponse, stack: stackTrace);
    if (e.toString().toLowerCase().contains("socketexception")) {
      httpResponse["error"] = "No internet connection";
      return httpResponse;
    }

    return httpResponse;
  }
}

Future<Map<String, dynamic>> postRequest(
    {var queryParameters, var data, Options options, @required var url}) async {
  SessionService _sessionService = locator<SessionService>();
  Map<String, dynamic> httpResponse = {};

  Dio _dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
  final firebasePerformanceInterceptor = DioFirebasePerformanceInterceptor();
  _dio.interceptors.add(firebasePerformanceInterceptor);

  recordCrashlyticsLog("post request at $url");
  // print(url);
  try {
    var response = await _dio.post(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      handleSession(response, _sessionService);

      if (response != null) {

        if (response.data["success"] == true) {
          httpResponse['data'] = response.data['data'];
          if (response.data.containsKey("message"))
            httpResponse["message"] = response.data["message"];

        } else {
          //// //print(response.data["error"]);
          httpResponse["error"] = response.data["error"];
        }

        return httpResponse;
      } // end of checking response

    }
  } on DioError catch (e, stackTrace) {
    var errorRes = e.response.data;
    print(errorRes);
    if (e.toString().toLowerCase().contains("socketexception")) {
      httpResponse["error"] = "No internet connection";
      return httpResponse;
    }
    if (errorRes is Map) {
      if (errorRes.containsKey("error")) {
        httpResponse["error"] = errorRes["error"];
        return httpResponse;
      }
    }

    handleError(e: e.toString(), httpResponse: httpResponse, stack: stackTrace);

    return httpResponse;
  }
}

handleError({String e, Map httpResponse, StackTrace stack}) {
  // //print('dio  error: ${e.toString()}');

  if (e != null) {
    String error = e.toString().toLowerCase();
    if (error.contains('404')) {
      httpResponse['error'] = error_msg_404;
    } else if (error.contains('500')) {
      httpResponse['error'] = error_msg_500;
    } else if (error.contains('401')) {
      httpResponse['error'] = unauthorized_error;
    } else if (error.contains('408')) {
      httpResponse['error'] = error_msg_408;
    } else if (error.contains('timeout')) {
      httpResponse['error'] = error_msg_timeout;
    } else if (error.contains('422')) {
      httpResponse['error'] = error_mdg_422;
    } else {
 //     FirebaseCrashlytics.instance.recordError(e, stack);

      httpResponse['error'] = error_error;
    }
  }
}

handleSession(Response response, SessionService service) {
  if (response.headers != null) {
    if (!service.hasSessionIdSet) {
      var sessionId = response.headers.value('sessionid');

      if (sessionId != null) {
        service.sessionId = sessionId;
        service.hasSessionIdSet = true;
      }
    }
  } // end of get/set header
}

throwErrorFunction(e) {
  throw Exception(['$e']);
}

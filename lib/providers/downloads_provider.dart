import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/providers/base_provider.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/services/database_service.dart';
import '../locator.dart';

class DownloadsProvider extends BaseProvider {
  var downloadsList;

  List<Track> _filteredTracks = [];
  List<String> filtersList = ["All"];
  List<Track> _downloadedTracks = [];

  List<Track> get downloadTracks => _downloadedTracks;
  List<Track> get filteredTracks => _filteredTracks;

  bool hasDownloadError = false;
  String downloadError = ' ';

  Future<bool> deleteDown({int id, int downloadId}) async {
    final res = await locator<ApiService>()
        .deleteDownload(trackId: id, downloadId: downloadId);
    if (res.containsKey("data")) {
      await DatabaseService().deleteDownloadItem(trackId: id);
      return true;
    } else if (res.containsKey("error")) {
      if (res['error'].toString().toLowerCase() ==
          "Download is already deleted".toLowerCase()) {
        await DatabaseService().deleteDownloadItem(trackId: id);
        return true;
      }
      return false;
    }
    notifyListeners();
    return false;
  }

  addIntoAll() {
    filteredTracks.clear();
    filteredTracks.addAll(_downloadedTracks);
  }
}

class DownloadFilter {
  final int id;
  final String name;
  DownloadFilter({this.id, this.name});
}

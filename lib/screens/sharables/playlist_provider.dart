import 'package:flutter/cupertino.dart';
import 'package:goodvibesoffl/DataStores/playlists/PlaylistModel.dart';
import 'package:goodvibesoffl/DataStores/playlists/playlistdbhelper.dart';
import 'package:goodvibesoffl/DataStores/playlists/tracksinplaylist/tracksinplaylistdbhelper.dart';
import 'package:goodvibesoffl/DataStores/playlists/tracksinplaylist/tracksinplaylistmodel.dart';
import 'package:intl/intl.dart';

class PlayListFunctions extends ChangeNotifier{

  PlaylistDatabaseHelper playlistDatabaseHelper=PlaylistDatabaseHelper();
  TracksInPlaylistDatabaseHelper tracksInPlaylistDatabaseHelper=TracksInPlaylistDatabaseHelper();

  void delete( int id) async {

    int result = await playlistDatabaseHelper.deletePlaylist(id);
    if (result != 0) {
      //    _showSnackBar(context, 'Note Deleted Successfully');
    }
  }
  void savenewplaylist(PlaylistModel playlistModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (playlistModel.id != null) {  // Case 1: Update operation
      result = await playlistDatabaseHelper.updatePlaylist(playlistModel);
    } else { // Case 2: Insert Operation
      result = await playlistDatabaseHelper.insertPlaylist(playlistModel);
    }

    if (result != 0) {  // Success
      print('Playlist Saved Successfully');
    } else {  // Failure
      print('Problem Saving Playlist');
    }

  }
  void savetracktoplaylist(TracksinPlaylistModel tracksinPlaylistModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (tracksinPlaylistModel.id != null) {  // Case 1: Update operation
      result = await tracksInPlaylistDatabaseHelper.updatetrackinPlaylist(tracksinPlaylistModel);
    } else { // Case 2: Insert Operation
      result = await tracksInPlaylistDatabaseHelper.inserttrackinPlaylist(tracksinPlaylistModel);
    }

    if (result != 0) {  // Success
      print('Playlist Saved Successfully');
    } else {  // Failure
      print('Problem Saving Playlist');
    }

  }
  void _deleteplaylist(PlaylistModel playlistModel) async {

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await playlistDatabaseHelper.deletePlaylist(playlistModel.id);
    if (result != 0) {
      print( 'Playlist Deleted Successfully');
    } else {
      print('Error Occured while Deleting Playlist');
    }
  }
  void _deletetrackplaylist(TracksinPlaylistModel tracksinPlaylistModel) async {

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await tracksInPlaylistDatabaseHelper.deletetrackinlaylist(tracksinPlaylistModel.id);
    if (result != 0) {
      print( 'Track in Playlist Deleted Successfully');
    } else {
      print('Error Occured while Deleting Track in Playlist');
    }
  }

}


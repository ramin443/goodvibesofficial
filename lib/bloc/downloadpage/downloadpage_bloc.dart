import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/models/music_model.dart';
import 'package:goodvibesoffl/models/playlist_model.dart';
import 'package:goodvibesoffl/repository/downloadRepository.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';

part 'downloadpage_event.dart';
part 'downloadpage_state.dart';

class DownloadpageBloc extends Bloc<DownloadpageEvent, DownloadpageState> {
  final _downloadRepository = DownloadRepository();
  String currentFilter = "All";
  bool _isDataLatest = false;

  DownloadpageBloc() : super(DownloadPageInitial());

  @override
  Stream<DownloadpageState> mapEventToState(
      DownloadpageEvent event,
      ) async* {
    /// initial fetch data
    if (event is DownloadPageFetchData) {
      if (state is DownloadPageInitial) {
        yield DownloadPageLoading();
        bool isOffline = await checkIfOffline();
        if (!isOffline) {
          // if Connected to internet
          await _downloadRepository.fetehDataFromDB();
          //if database is empty
          if (_downloadRepository.isEmpty) {
            await _downloadRepository.fetchDataFromServer();
            if (_downloadRepository.hasDownloadError) {
              // if server throw Error
              yield DownloadPageWithError(
                  errorMessage: _downloadRepository.downloadError);
            } else {
              // if server data is empty
              _isDataLatest = true;
              if (_downloadRepository.isEmpty)
                yield DownloadPageSuccessWithServerNoData(
                    filterCategory: _downloadRepository.filterCategory,
                    currentFilter: currentFilter);
              // if server data has data
              else
                yield DownloadPageSuccessWithServerData(
                    downloadedTracks: _downloadRepository.downloadedTracks,
                    filterCategory: _downloadRepository.filterCategory,
                    currentFilter: currentFilter);
            }
          }
          //-------------------------------------------------------
          else if (_downloadRepository.isNotEmpty) {
            //if database is not empty
            yield DownloadPageSuccessWithDBData(
                downloadedTracks: _downloadRepository.downloadedTracks,
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter);
            final res = await _downloadRepository.fetchDataFromServer();
            //if server throw error
            if (_downloadRepository.hasDownloadError) {
              yield DownloadPageApiFetchError(
                  errorMessage: _downloadRepository.downloadError);
              yield DownloadPageSuccessWithDBData(
                  downloadedTracks: _downloadRepository.downloadedTracks,
                  filterCategory: _downloadRepository.filterCategory,
                  currentFilter: currentFilter);
            } else {
              // if we get data from server
              _isDataLatest = true;
              if (res) {
                yield DownloadPageSuccessWithServerData(
                    downloadedTracks: _downloadRepository.downloadedTracks,
                    filterCategory: _downloadRepository.filterCategory,
                    currentFilter: currentFilter);
              }
            }
          }
        }
        //-------------------------------------------------
        else {
          // if Not Connected to internet
          await _downloadRepository.fetehDataFromDB();
          if (_downloadRepository.isEmpty) {
            // if download Repository is empty
            yield DownloadPageSuccessWithDBNoData(
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter);
          } else {
            //if download repository is not empty
            yield DownloadPageSuccessWithDBData(
                downloadedTracks: _downloadRepository.downloadedTracks,
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter);
          }
        }
      } else if (state is DownloadPageSuccessWithDBData ||
          state is DownloadPageSuccessWithDBNoData) {
        //Execute only when data is not latest i.e data not fetched from server
        if (!_isDataLatest) {
          final res = await _downloadRepository.fetchDataFromServer();
          if (_downloadRepository.hasDownloadError) {
            yield DownloadPageApiFetchError(
                errorMessage: _downloadRepository.downloadError);
            if (_downloadRepository.downloadedTracks.isEmpty) {
              yield DownloadPageSuccessWithDBNoData(
                  currentFilter: currentFilter,
                  filterCategory: _downloadRepository.filterCategory);
            } else {
              yield DownloadPageSuccessWithDBData(
                downloadedTracks: _downloadRepository.downloadedTracks,
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter,
              );
            }
          } else {
            _isDataLatest = true;
            //When server data is not empty
            if (_downloadRepository.isNotEmpty) {
              if (res) {
                yield DownloadPageSuccessWithServerData(
                    downloadedTracks: _downloadRepository.downloadedTracks,
                    filterCategory: _downloadRepository.filterCategory,
                    currentFilter: currentFilter);
              }
            }
            //When server data is empty
            else
              yield DownloadPageSuccessWithServerNoData(
                  filterCategory: _downloadRepository.filterCategory,
                  currentFilter: currentFilter);
          }
        }
      } else if (state is DownloadPageSuccessWithServerData ||
          state is DownloadPageSuccessWithServerNoData) {
        //DO Nothing
      }
    }

    //// filter data
    else if (event is DownloadPageFilterData) {
      currentFilter = event.filterString;
      if (state is DownloadPageSuccessWithDBData) {
        yield DownloadPageSuccessWithDBData(
            filterCategory: _downloadRepository.filterCategory,
            downloadedTracks:
            filterList(currentFilter, _downloadRepository.downloadedTracks),
            currentFilter: currentFilter,
            playlists: currentFilter == 'Courses'
                ? _downloadRepository.playlists
                : []);
      } else if (state is DownloadPageSuccessWithServerData) {
        yield DownloadPageSuccessWithServerData(
            filterCategory: _downloadRepository.filterCategory,
            downloadedTracks:
            filterList(currentFilter, _downloadRepository.downloadedTracks),
            currentFilter: currentFilter,
            playlists: currentFilter == 'Courses'
                ? _downloadRepository.playlists
                : []);
      }
    }

    /// dowload add track
    else if (event is DownloadPageAddTrack) {
      if (_downloadRepository.addTrackToRepository(event.track)) {
        if (state is DownloadPageSuccessWithDBData ||
            state is DownloadPageSuccessWithDBNoData) {
          yield DownloadPageSuccessWithDBData(
              filterCategory: _downloadRepository.filterCategory,
              downloadedTracks: filterList(
                  currentFilter, _downloadRepository.downloadedTracks),
              currentFilter: currentFilter);
        } else if (state is DownloadPageSuccessWithServerData ||
            state is DownloadPageSuccessWithServerNoData) {
          yield DownloadPageSuccessWithServerData(
              filterCategory: _downloadRepository.filterCategory,
              downloadedTracks: filterList(
                  currentFilter, _downloadRepository.downloadedTracks),
              currentFilter: currentFilter);
        }
      }
    }

    ///refresh tracks
    else if (event is DownloadPageRefreshTracks) {
      if (state is DownloadPageSuccessWithDBData ||
          state is DownloadPageSuccessWithDBNoData) {
        yield DownloadPageSuccessWithDBData(
            filterCategory: _downloadRepository.filterCategory,
            downloadedTracks:
            filterList(currentFilter, _downloadRepository.downloadedTracks),
            currentFilter: currentFilter);
      } else if (state is DownloadPageSuccessWithServerData ||
          state is DownloadPageSuccessWithServerNoData) {
        yield DownloadPageSuccessWithServerData(
            filterCategory: _downloadRepository.filterCategory,
            downloadedTracks:
            filterList(currentFilter, _downloadRepository.downloadedTracks),
            currentFilter: currentFilter);
      }
    }

    //// delete download

    else if (event is DownloadPageDeleteTrack) {
      if (_downloadRepository.deleteTrackToRepository(event.track)) {
        if (state is DownloadPageSuccessWithDBData) {
          if (_downloadRepository.isEmpty)
            yield DownloadPageSuccessWithDBNoData(
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter);
          else
            yield DownloadPageSuccessWithDBData(
                filterCategory: _downloadRepository.filterCategory,
                downloadedTracks: filterList(
                    currentFilter, _downloadRepository.downloadedTracks),
                currentFilter: currentFilter);
        } else if (state is DownloadPageSuccessWithServerData) {
          if (_downloadRepository.isEmpty)
            yield DownloadPageSuccessWithServerNoData(
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter);
          else
            yield DownloadPageSuccessWithServerData(
                filterCategory: _downloadRepository.filterCategory,
                downloadedTracks: filterList(
                    currentFilter, _downloadRepository.downloadedTracks),
                currentFilter: currentFilter);
        }
      }
    }

    ///
    else if (event is DeletePlayList) {
      _downloadRepository.deletePlaylist(event.playlist);

      yield DownloadPageSuccessWithServerData(
          filterCategory: _downloadRepository.filterCategory,
          downloadedTracks:
          filterList(currentFilter, _downloadRepository.downloadedTracks),
          playlists: _downloadRepository.playlists,
          currentFilter: currentFilter);
    }

    //// refetch tracks
    else if (event is DownloadPageReFetchTrack) {
      _isDataLatest = false;
      yield DownloadPageApiLoading();
      bool isOffline = await checkIfOffline();
      if (!isOffline) {
        // if Connected to internet
        await _downloadRepository.fetehDataFromDB();
        //if database is empty
        if (_downloadRepository.isEmpty) {
          await _downloadRepository.fetchDataFromServer();
          if (_downloadRepository.hasDownloadError) {
            // if server throw Error
            yield DownloadPageWithError(
                errorMessage: _downloadRepository.downloadError);
          } else {
            // if server data is empty
            _isDataLatest = true;
            if (_downloadRepository.isEmpty)
              yield DownloadPageSuccessWithServerNoData(
                  filterCategory: _downloadRepository.filterCategory,
                  currentFilter: currentFilter);
            // if server data has data
            else
              yield DownloadPageSuccessWithServerData(
                  downloadedTracks: _downloadRepository.downloadedTracks,
                  filterCategory: _downloadRepository.filterCategory,
                  currentFilter: currentFilter);
          }
        }
        //-------------------------------------------------------
        else if (_downloadRepository.isNotEmpty) {
          //if database is not empty
          yield DownloadPageSuccessWithDBData(
              downloadedTracks: _downloadRepository.downloadedTracks,
              filterCategory: _downloadRepository.filterCategory,
              currentFilter: currentFilter);
          final res = await _downloadRepository.fetchDataFromServer();
          //if server throw error
          if (_downloadRepository.hasDownloadError) {
            yield DownloadPageApiFetchError(
                errorMessage: _downloadRepository.downloadError);
            yield DownloadPageSuccessWithDBData(
                downloadedTracks: _downloadRepository.downloadedTracks,
                filterCategory: _downloadRepository.filterCategory,
                currentFilter: currentFilter);
          } else {
            // if we get data from server
            _isDataLatest = true;
            if (res) {
              yield DownloadPageSuccessWithServerData(
                  downloadedTracks: _downloadRepository.downloadedTracks,
                  filterCategory: _downloadRepository.filterCategory,
                  currentFilter: currentFilter);
            }
          }
        }
      }
      //-------------------------------------------------
      else {
        // if Not Connected to internet
        await _downloadRepository.fetehDataFromDB();
        if (_downloadRepository.isEmpty) {
          // if download Repository is empty
          yield DownloadPageSuccessWithDBNoData(
              filterCategory: _downloadRepository.filterCategory,
              currentFilter: currentFilter);
        } else {
          //if download repository is not empty
          yield DownloadPageSuccessWithDBData(
              downloadedTracks: _downloadRepository.downloadedTracks,
              filterCategory: _downloadRepository.filterCategory,
              currentFilter: currentFilter);
        }
      }
    }
  }
}

List<Track> filterList(String filterName, List<Track> downloadTracks) {
  if (filterName == "All") {
    return downloadTracks;
  } else {
    List<Track> temp = [];
    temp = downloadTracks.where((track) => filterName == track.cname).toList();
    return temp;
  }
}

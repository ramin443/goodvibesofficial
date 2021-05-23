import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadTaskModel {
  String taskId;
  int audioId;
  String audioTitle;
  String audioPath;
  int progress;
  DownloadTaskStatus downloadTaskStatus;
  bool isDownloading;
  String fileName;
  DownloadTaskModel(
      {this.taskId,
        this.audioId,
        this.audioTitle,
        this.progress,
        this.audioPath,
        this.downloadTaskStatus,
        this.isDownloading,
        this.fileName});

  copyWith(
      {String taskId,
        int audioId,
        String audioTitle,
        String audioPath,
        int progress,
        DownloadTaskStatus downloadTaskStatus,
        bool isDownloading,
        String fileName}) {
    return DownloadTaskModel(
        taskId: taskId ?? this.taskId,
        audioId: audioId ?? this.audioId,
        audioTitle: audioTitle ?? this.audioTitle,
        progress: progress ?? this.progress,
        audioPath: audioPath ?? this.audioPath,
        downloadTaskStatus: downloadTaskStatus ?? this.downloadTaskStatus,
        isDownloading: isDownloading ?? this.isDownloading,
        fileName: fileName ?? this.fileName);
  }
}

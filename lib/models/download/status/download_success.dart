import 'package:ass_downloader_example/models/download/status/download_status.dart';

class FilesWereDownloadedSuccessfully extends DownloadSuccess {
  const FilesWereDownloadedSuccessfully(this.urls);

  @override
  String get name => 'files_downloaded_successfully';

  final List<String> urls;
}

class FilesAlreadyDownloaded extends FilesWereDownloadedSuccessfully {
  const FilesAlreadyDownloaded({List<String>? fileUrls})
      : super(fileUrls ?? const []);

  @override
  String get name => 'files_are_already_downloaded_success';
}

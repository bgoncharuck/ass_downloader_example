import 'package:ass_downloader_example/models/download/status/download_status.dart';

class FilesAreAlreadyDownloadedSuccess extends DownloadSuccess {
  const FilesAreAlreadyDownloadedSuccess();

  @override
  String get name => 'files_are_already_downloaded_success';
}

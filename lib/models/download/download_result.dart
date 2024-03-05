import 'package:ass_downloader_example/models/download/download_status.dart';

class DownloadResult {
  const DownloadResult({
    required this.id,
    required this.url,
    required this.status,
  });

  final String id;
  final String url;
  final DownloadStatus status;
}

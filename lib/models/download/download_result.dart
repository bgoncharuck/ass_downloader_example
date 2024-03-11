import 'package:ass_downloader_example/models/download/status/download_status.dart';

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

extension DownloadResultExtension on Iterable<DownloadResult> {
  DownloadResult? firstOccurrenceOfStatus<S extends DownloadStatus>() {
    if (any((result) => result.status is S)) {
      return firstWhere(
        (result) => result.status is S,
      );
    }
    return null;
  }
}

abstract class DownloadStatus {
  String get name;
}

class DownloadError implements DownloadStatus {
  @override
  final String name = 'error';
}

class DownloadSuccess implements DownloadStatus {
  @override
  final String name = 'success';
}

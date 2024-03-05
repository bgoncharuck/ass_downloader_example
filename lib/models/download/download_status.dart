abstract class DownloadStatus {
  String get name;
}

/// more specific error classes will be created later and
/// will be used for type check is! DownloadError
class DownloadError implements DownloadStatus {
  @override
  final String name = 'error';
}

class DownloadSuccess implements DownloadStatus {
  @override
  final String name = 'success';
}

abstract class DownloadStatus {
  String get name;
}

/// more specific error classes will be created later and
/// will be used for type check is! DownloadError
class DownloadError implements DownloadStatus {
  const DownloadError();

  @override
  String get name => 'error';
}

class DownloadSuccess implements DownloadStatus {
  const DownloadSuccess();

  @override
  String get name => 'success';
}

abstract class DownloadStatus {
  String get name;
  bool get isError;
}

class DownloadError implements DownloadStatus {
  const DownloadError();

  @override
  String get name => 'error';

  @override
  bool get isError => true;
}

class DownloadSuccess implements DownloadStatus {
  const DownloadSuccess();

  @override
  String get name => 'success';

  @override
  bool get isError => false;
}

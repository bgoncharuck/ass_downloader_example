// ignore: one_member_abstracts
abstract class DownloadStrategy {
  Future<bool> downloadFile({
    required String url,
    required String path,
  });
}

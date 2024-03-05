import 'package:ass_downloader_example/models/download/download_result.dart';

// ignore: one_member_abstracts
abstract class DownloadStrategy {
  Future<DownloadResult> downloadFile({
    required String url,
    required String path,
  });
}

import 'dart:io';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download/download_status.dart';
import 'package:ass_downloader_example/services/download_strategy/download_strategy.dart';
import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shortid/shortid.dart';

/// simple http download through future
/// that only gives information about if the download was successful
class BinaryResultFutureDownloadStrategy implements DownloadStrategy {
  @override
  Future<DownloadResult> downloadFile({
    required String url,
    required String path,
    String? id,
  }) async {
    final uniqueId = id ?? shortid.generate();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        await log.message('Download failed, ${response.statusCode}, $path');
        return DownloadResult(
          id: uniqueId,
          url: url,
          status: DownloadError(),
        );
      }

      final file = File('');
      await file.writeAsBytes(response.bodyBytes);
      return DownloadResult(
        id: uniqueId,
        url: url,
        status: DownloadSuccess(),
      );
    } catch (e, t) {
      await log.exception(e, t);
    }

    return DownloadResult(
      id: uniqueId,
      url: url,
      status: DownloadError(),
    );
  }
}

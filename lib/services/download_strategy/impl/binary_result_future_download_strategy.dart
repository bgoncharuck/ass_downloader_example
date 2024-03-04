import 'dart:io';
import 'package:ass_downloader_example/services/download_strategy/download_strategy.dart';
import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:http/http.dart' as http;

class BinaryResultFutureDownloadStrategy implements DownloadStrategy {
  @override
  Future<bool> downloadFile({
    required String url,
    required String path,
  }) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        await log.message('Download failed, ${response.statusCode}, $path');
        return false;
      }

      final file = File('');
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e, t) {
      await log.exception(e, t);
    }
    return false;
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ass_downloader_example/services/asset_path/asset_path.dart';

class DefaultAssetPath implements AssetPath {
  final Map<String, String> _filePath = {};

  @override
  Future<bool> exists(String fileName) async {
    final filePath = getFilePath(fileName);
    if (filePath == null) {
      return false;
    }

    final savePath = await fileSavePath(fileName);
    final exists = File(savePath).existsSync();
    if (!exists) {
      return false;
    }

    _filePath[fileName] = savePath;
    return true;
  }

  @override
  Future<String> get savePath async =>
      (await getApplicationDocumentsDirectory()).path;

  @override
  Future<String> fileSavePath(String fileName) async =>
      '${await savePath}/$fileName';

  @override
  String? getFilePath(String fileName) {
    return _filePath[fileName];
  }

  @override
  String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.last;
  }

  @override
  String? getFilePathByUrl(String url) {
    final fileName = getFileNameFromUrl(url);
    return _filePath[fileName];
  }

  @override
  void put(String fileName, String filePath) {
    _filePath[fileName] = filePath;
  }
}

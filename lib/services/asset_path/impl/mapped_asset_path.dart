import 'dart:io';
import 'package:ass_downloader_example/services/asset_path/asset_path.dart';
import 'package:path_provider/path_provider.dart';

class MappedAssetPath implements AssetPath {
  final Map<String, String> _filePath = {};

  @override
  Future<bool> exists(String fileName) async {
    final filePath = getFilePath(fileName);
    if (filePath != null) {
      return true;
    }

    final savePath = await fileSavePath(fileName);
    final exists = File(savePath).existsSync();
    if (!exists) {
      return false;
    }

    _filePath[fileName] = savePath;
    return true;
  }

  String? _savePath;

  @override
  Future<String> get savePath async {
    _savePath ??= (await getApplicationDocumentsDirectory()).path;
    return _savePath!;
  }

  @override
  Future<String> fileSavePath(String fileName) async =>
      '${await savePath}/$fileName'..replaceAll('/', '//');

  @override
  String? getFilePath(String fileName) {
    //
    return _filePath[fileName];
  }

  @override
  String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    return uri.path;
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

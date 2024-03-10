abstract class AssetPath {
  Future<bool> exists(String fileName);
  Future<String> get savePath;
  Future<String> fileSavePath(String fileName);
  String? getFilePath(String fileName);
  String getFileNameFromUrl(String url);
  String? getFilePathByUrl(String url);
  void put(String fileName, String filePath);
}

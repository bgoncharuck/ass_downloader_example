/// Contract for managing asset file paths.
abstract class AssetPath {
  /// Asynchronously checks if a file with the given name already exists.
  ///
  /// Returns a [Future] that completes with a boolean indicating whether
  /// the file exists or not.
  Future<bool> exists(String fileName);

  /// Retrieves the directory where files can be downloaded to.
  ///
  /// Returns a [Future] that completes with the path to the download directory.
  Future<String> get savePath;

  /// Generates the full file path where a file
  /// with the given name should be saved.
  Future<String> fileSavePath(String fileName);

  /// Retrieves the file path associated with the given filename, if it exists.
  String? getFilePath(String fileName);

  /// Extracts the filename from a provided URL.
  String getFileNameFromUrl(String url);

  /// Retrieves the file path associated with a given URL,
  /// if it has been previously
  /// saved or associated with a path.
  String? getFilePathByUrl(String url);

  /// Associates a filename with a specific file path.
  ///
  /// This can be used for caching purposes or
  /// to maintain a record of downloaded
  /// files and their locations.
  void put(String fileName, String filePath);
}

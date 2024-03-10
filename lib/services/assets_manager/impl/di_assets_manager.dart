import 'dart:io';
import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download/status/download_errors.dart';
import 'package:ass_downloader_example/models/download/status/download_status.dart';
import 'package:ass_downloader_example/models/download/status/download_success.dart';
import 'package:ass_downloader_example/services/asset_path/asset_path.dart';
import 'package:ass_downloader_example/services/assets_manager/assets_manager.dart';
import 'package:ass_downloader_example/services/connection/connection_checker_strategy.dart';
import 'package:ass_downloader_example/services/download_strategy/download_strategy.dart';
import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:shortid/shortid.dart';

class DIAssetsManager implements AssetsManager {
  const DIAssetsManager({
    required this.connectionChecker,
    required this.download,
    required this.assetPath,
  });

  final ConnectionCheckerStrategy connectionChecker;
  final DownloadStrategy download;
  final AssetPath assetPath;

  @override
  Future<DownloadResult> syncAssetGroup({
    required AssetGroup group,
    required List<String> appDomains,
    String? id,
  }) async {
    final uniqueId = id ?? shortid.generate();
    final reachableDomains = await connectionChecker.isConnected(appDomains);
    if (reachableDomains.isEmpty) {
      return DownloadResult(
        id: uniqueId,
        url: '',
        status: DomainsNotReachableError(appDomains),
      );
    }

    if (group.urls.isEmpty) {
      return DownloadResult(
        id: uniqueId,
        url: '',
        status: const NoUrlsProvidedInAssetGroupError(),
      );
    }

    final missingFiles = await findMissingFileUrls(group.urls);
    if (missingFiles.isEmpty) {
      return DownloadResult(
        id: uniqueId,
        url: '',
        status: const FilesAlreadyDownloaded(),
      );
    }

    final downloadResults = await downloadFiles(missingFiles);
    final successfullyDownloadedFiles = <String>[];
    final failedDownloads = <String>[];

    for (final result in downloadResults) {
      if (result.status is DownloadSuccess) {
        successfullyDownloadedFiles.add(result.url);
      } else {
        failedDownloads.add(result.url);
      }
    }

    for (final file in successfullyDownloadedFiles) {
      final savePath = await assetPath.savePath;
      assetPath.put(file, '$savePath/$file'..replaceAll('/', '//'));
    }

    if (failedDownloads.isNotEmpty) {
      await log.message(
        'Files were not downloaded: ${failedDownloads.join(
          ', ',
        )}',
      );

      if (successfullyDownloadedFiles.isEmpty) {
        return DownloadResult(
          id: uniqueId,
          url: '',
          status: NoFilesWereDownloadedSuccessfullyError(failedDownloads),
        );
      }

      return DownloadResult(
        id: uniqueId,
        url: '',
        status: SomeFilesWereNotDownloadedError(failedDownloads),
      );
    }

    return DownloadResult(
      id: uniqueId,
      url: '',
      status: FilesWereDownloadedSuccessfully(
        successfullyDownloadedFiles,
      ),
    );
  }

  Future<List<DownloadResult>> downloadFiles(Iterable<String> urls) async {
    final downloadFutures = urls.map((url) async {
      final fileName = assetPath.getFileNameFromUrl(url);
      final savePath = await assetPath.fileSavePath(fileName);
      return download.downloadFile(url: url, path: savePath);
    }).toList();

    final downloadResults = await Future.wait(downloadFutures);
    return downloadResults;
  }

  Future<List<String>> findMissingFileUrls(Iterable<String> urls) async {
    final missingFiles = <String>[];
    for (final url in urls) {
      final fileName = assetPath.getFileNameFromUrl(url);
      final filePath = await assetPath.fileSavePath(fileName);
      if (!File(filePath).existsSync()) {
        missingFiles.add(url);
      }
    }
    return missingFiles;
  }

  @override
  String? getAssetPath(String filename) => assetPath.getFilePath(filename);

  @override
  String? getAssetPathByUrl(String url) => assetPath.getFilePathByUrl(url);
}

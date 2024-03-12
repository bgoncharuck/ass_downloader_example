import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download/status/download_errors.dart';
import 'package:ass_downloader_example/models/download/status/download_status.dart';
import 'package:ass_downloader_example/models/download/status/download_success.dart';
import 'package:ass_downloader_example/models/download_group.dart';
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
  Future<DownloadResult> syncDownloadGroup({
    required List<DownloadGroup> groups,
    required List<String> appDomains,
    String? id,
  }) async {
    final uniqueId = id ?? shortid.generate();

    /// select best domain and init download groups with it
    final reachableDomains = await connectionChecker.isConnected(appDomains);
    if (reachableDomains.isEmpty) {
      return DownloadResult(
        id: uniqueId,
        url: '',
        status: DomainsNotReachableError(appDomains),
      );
    }
    final selectedDomain = reachableDomains.first;
    try {
      for (final downloadGroup in groups) {
        downloadGroup.init(selectedDomain);
      }
    } catch (e, t) {
      await log.exception(e, t);
      return DownloadResult(
        id: id!,
        url: '',
        status: const DownloadGroupWasNotInitialized(),
      );
    }

    /// create download scenarios
    final downloadScenarios = <AssetGroup>[];
    for (final downloadGroup in groups) {
      downloadScenarios.addAll(downloadGroup.assets.values);
    }

    /// prepare downloads
    final downloads = <Future<DownloadResult>>[];
    for (final downloadScenario in downloadScenarios) {
      downloads.add(
        syncAssetGroup(group: downloadScenario),
      );
    }

    /// download
    var downloadResults = <DownloadResult>[];
    try {
      downloadResults = await Future.wait(downloads);
    } catch (e, t) {
      await log.exception(e, t);
      return DownloadResult(
        id: uniqueId,
        url: '',
        status: const EventLoopOverflowError(),
      );
    }

    /// on any error return the most important one
    if (downloadResults.any((result) => result.status.isError)) {
      return errorPriority(downloadResults, id!);
    }

    return DownloadResult(
      id: uniqueId,
      url: '',

      /// you can use FilesWereDownloadedSuccessfully if needed
      status: const DownloadSuccess(),
    );
  }

  DownloadResult errorPriority(List<DownloadResult> results, String id) {
    DownloadResult? orderedResult;

    orderedResult ??=
        results.firstOccurrenceOfStatus<NoUrlsProvidedInAssetGroupError>();
    orderedResult ??=
        results.firstOccurrenceOfStatus<DomainsNotReachableError>();
    orderedResult ??= results
        .firstOccurrenceOfStatus<NoFilesWereDownloadedSuccessfullyError>();
    orderedResult ??=
        results.firstOccurrenceOfStatus<SomeFilesWereNotDownloadedError>();

    if (orderedResult != null) {
      return orderedResult;
    }

    return DownloadResult(
      id: id,
      url: '',
      status: const DownloadError(),
    );
  }

  @override
  Future<DownloadResult> syncAssetGroup({
    required AssetGroup group,
    String? id,
  }) async {
    final uniqueId = id ?? shortid.generate();

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

    final savePath = await assetPath.savePath;
    for (final url in successfullyDownloadedFiles) {
      final file = assetPath.getFileNameFromUrl(url);
      final path = '$savePath/$file'..replaceAll('/', '//');
      assetPath.put(file, path);
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
      if (!await assetPath.exists(fileName)) {
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

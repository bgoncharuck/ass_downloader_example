import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download/download_errors.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download/download_status.dart';
import 'package:ass_downloader_example/services/asset_path/asset_path.dart';
import 'package:ass_downloader_example/services/assets_manager/assets_manager.dart';
import 'package:ass_downloader_example/services/connection/connection_checker_strategy.dart';
import 'package:ass_downloader_example/services/download_strategy/download_strategy.dart';
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

    final urls = group.urls;
  }

  Future<List<DownloadResult>> _downloadFiles(List<String> urls) async {
    final downloadFutures = urls.map((url) async {
      final fileName = assetPath.getFileNameFromUrl(url);
      final savePath = await assetPath.fileSavePath(fileName);
      return download.downloadFile(url: url, path: savePath);
    }).toList();

    final downloadResults = await Future.wait(downloadFutures);
    return downloadResults;
  }

  @override
  String? getAssetPath(String filename) => assetPath.getFilePath(filename);

  @override
  String? getAssetPathByUrl(String url) => assetPath.getFilePathByUrl(url);
}

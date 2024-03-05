import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/services/asset_path/asset_path.dart';
import 'package:ass_downloader_example/services/assets_manager/assets_manager.dart';
import 'package:ass_downloader_example/services/connection/connection_checker_strategy.dart';
import 'package:ass_downloader_example/services/download_strategy/download_strategy.dart';

class LightweightAssetsManager implements AssetsManager {
  const LightweightAssetsManager({
    required this.connectionCheckerStrategy,
    required this.downloadStrategy,
    required this.assetPath,
  });

  final ConnectionCheckerStrategy connectionCheckerStrategy;
  final DownloadStrategy downloadStrategy;
  final AssetPath assetPath;

  @override
  Future<void> syncAssetGroup(AssetGroup group) async {}

  @override
  String? getAssetPath(String filename) => assetPath.getFilePath(filename);

  @override
  String? getAssetPathByUrl(String url) => assetPath.getFilePathByUrl(url);
}

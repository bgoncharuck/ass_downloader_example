import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download_group.dart';

AssetsManager? assetsManager;

abstract class AssetsManager {
  Future<DownloadResult> syncDownloadGroup({
    required List<DownloadGroup> groups,
    required List<String> appDomains,
    String? id,
  });

  Future<DownloadResult> syncAssetGroup({
    required AssetGroup group,
    String? id,
  });

  String? getAssetPath(String filename);

  String? getAssetPathByUrl(String url);
}

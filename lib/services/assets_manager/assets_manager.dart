import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';

abstract class AssetsManager {
  Future<DownloadResult> syncAssetGroup({
    required AssetGroup group,
    required List<String> appDomains,
    String? id,
  });

  String? getAssetPath(String filename);

  String? getAssetPathByUrl(String url);
}

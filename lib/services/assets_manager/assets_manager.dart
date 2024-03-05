import 'package:ass_downloader_example/models/asset_group.dart';

abstract class AssetsManager {
  Future<void> syncAssetGroup(AssetGroup group);

  String? getAssetPath(String filename);

  String? getAssetPathByUrl(String url);
}

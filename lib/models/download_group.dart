import 'package:ass_downloader_example/models/asset_group.dart';

abstract class DownloadGroup {
  String get name;
  Map<String, AssetGroup> get assets;
  void init(String domain);
}

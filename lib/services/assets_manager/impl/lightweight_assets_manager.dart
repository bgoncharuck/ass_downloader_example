import 'package:ass_downloader_example/services/asset_path/impl/mapped_asset_path.dart';
import 'package:ass_downloader_example/services/assets_manager/impl/di_assets_manager.dart';
import 'package:ass_downloader_example/services/connection/impl/http_ping_strategy.dart';
import 'package:ass_downloader_example/services/download_strategy/impl/binary_result_future_download_strategy.dart';

class LightweightAssetsManager extends DIAssetsManager {
  LightweightAssetsManager()
      : super(
          connectionChecker: const HttpPingStrategy(),
          download: const BinaryResultFutureDownloadStrategy(),
          assetPath: MappedAssetPath(),
        );
}

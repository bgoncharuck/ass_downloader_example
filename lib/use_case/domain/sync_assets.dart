import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download/status/download_status.dart';
import 'package:ass_downloader_example/models/download_groups/download_groups.dart';
import 'package:ass_downloader_example/services/assets_manager/assets_manager.dart';
import 'package:ass_downloader_example/services/assets_manager/impl/lightweight_assets_manager.dart';
import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

class SyncAssets with IUseCase<void, DownloadResult> {
  const SyncAssets();

  @override
  Future<DownloadResult> execute({void params}) async {
    try {
      assetsManager ??= LightweightAssetsManager();
      final appDomains = [
        env['DOMAIN_URL'],
        env['SECONDARY_DOMAIN_URL'],
      ];

      return await assetsManager!.syncDownloadGroups(
        groups: downloadGroups.values,
        appDomains: appDomains,
      );
    } catch (e, t) {
      await log.exception(e, t);
      return const DownloadResult(
        id: 'sync_assets',
        url: '',
        status: DownloadError(),
      );
    }
  }
}

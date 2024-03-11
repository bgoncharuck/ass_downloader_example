import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/asian_animals.dart';
import 'package:ass_downloader_example/models/download/download_result.dart';
import 'package:ass_downloader_example/models/download/status/download_status.dart';
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
      final appDomains = [env['DOMAIN_URL']];

      final asianAnimalsAssetGroups = asianAnimals.keys.map((name) async {
        return assetsManager!.syncAssetGroup(
          group: asianAnimals[name]!,
          appDomains: appDomains,
        );
      }).toList();

      final downloadResults = <DownloadResult>[];
      for (final downloadGroup in [
        ...asianAnimalsAssetGroups,
      ]) {
        downloadResults.add(await downloadGroup);
      }

//
      if (downloadResults.any((result) => result.status.isError)) {
        //
        return const DownloadResult(
          id: 'sync_assets',
          url: '',
          status: DownloadError(),
        );
      }

      return const DownloadResult(
        id: 'sync_assets',
        url: '',
        status: DownloadSuccess(),
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

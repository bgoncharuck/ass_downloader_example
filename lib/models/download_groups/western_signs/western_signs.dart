import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download_group.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/aquarius.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/aries.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/cancer.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/capricorn.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/gemini.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/leo.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/libra.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/pisces.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/sagittarius.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/scorpio.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/taurus.dart';
import 'package:ass_downloader_example/models/download_groups/western_signs/virgo.dart';

final westernSigns = WesternSigns();

/// download group of the image asset groups
/// dedicated to the western astrology signs
class WesternSigns implements DownloadGroup {
  @override
  String get name => 'Western Signs';

  @override
  Map<String, AssetGroup> assets = {};

  @override
  void init(String domain) {
    assets.addAll({
      /// image asset groups
      'aquarius': AquariusAssetGroup(domain),
      'pisces': PiscesAssetGroup(domain),
      'aries': AriesAssetGroup(domain),
      'taurus': TaurusAssetGroup(domain),
      'gemini': GeminiAssetGroup(domain),
      'cancer': CancerAssetGroup(domain),
      'leo': LeoAssetGroup(domain),
      'virgo': VirgoAssetGroup(domain),
      'libra': LibraAssetGroup(domain),
      'scorpio': ScorpioAssetGroup(domain),
      'sagittarius': SagittariusAssetGroup(domain),
      'capricorn': CapricornAssetGroup(domain),
    });
    //
  }
}

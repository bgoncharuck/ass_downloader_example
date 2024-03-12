import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download_group.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/dog.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/dragon.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/goat.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/horse.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/monkey.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/ox.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/pig.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/rabbit.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/rat.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/rooster.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/snake.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/tiger.dart';

final asianAnimals = AsianAnimals();

class AsianAnimals implements DownloadGroup {
  @override
  String get name => 'Asian Animals';

  @override
  Map<String, AssetGroup> assets = {};

  @override
  void init(String domain) {
    assets.addAll({
      'tiger': TigerAssetGroup(domain),
      'rabbit': RabbitAssetGroup(domain),
      'dragon': DragonAssetGroup(domain),
      'snake': SnakeAssetGroup(domain),
      'horse': HorseAssetGroup(domain),
      'goat': GoatAssetGroup(domain),
      'monkey': MonkeyAssetGroup(domain),
      'rooster': RoosterAssetGroup(domain),
      'dog': DogAssetGroup(domain),
      'pig': PigAssetGroup(domain),
      'rat': RatAssetGroup(domain),
      'ox': OxAssetGroup(domain),
    });
    //
  }
}

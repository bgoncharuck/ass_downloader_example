import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/dog.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/dragon.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/goat.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/horse.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/monkey.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/ox.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/pig.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/rabbit.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/rat.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/rooster.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/snake.dart';
import 'package:ass_downloader_example/models/asset_groups/asian_animals/tiger.dart';

final asianAnimals = <String, AssetGroup>{
  'tiger': TigerAssetGroup(),
  'rabbit': RabbitAssetGroup(),
  'dragon': DragonAssetGroup(),
  'snake': SnakeAssetGroup(),
  'horse': HorseAssetGroup(),
  'goat': GoatAssetGroup(),
  'monkey': MonkeyAssetGroup(),
  'rooster': RoosterAssetGroup(),
  'dog': DogAssetGroup(),
  'pig': PigAssetGroup(),
  'rat': RatAssetGroup(),
  'ox': OxAssetGroup(),
};

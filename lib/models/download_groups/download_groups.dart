import 'package:ass_downloader_example/models/download_group.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/asian_animals.dart';

Map<String, DownloadGroup> get downloadGroups {
  return {
    asianAnimals.name: asianAnimals,
  };
}

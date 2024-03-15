import 'package:ass_downloader_example/models/asset_group.dart';

class AquariusAssetGroup extends ImageAssetGroup {
  AquariusAssetGroup(String domain)
      : super(
          groupName: 'aquarius',
          baseUrl: domain,
          assets: [
            white,
            wood,
            fire,
            earth,
            metal,
            water,
          ],
          width: 120,
          height: 120,
        );

  static const String white = 'assets/images/animal/aquarius/white.png';
  static const String wood = 'assets/images/animal/aquarius/wood.png';
  static const String fire = 'assets/images/animal/aquarius/fire.png';
  static const String earth = 'assets/images/animal/aquarius/earth.png';
  static const String metal = 'assets/images/animal/aquarius/metal.png';
  static const String water = 'assets/images/animal/aquarius/water.png';
}

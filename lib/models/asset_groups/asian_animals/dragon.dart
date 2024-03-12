import 'package:ass_downloader_example/models/asset_group.dart';

class DragonAssetGroup extends ImageAssetGroup {
  DragonAssetGroup(String domain)
      : super(
          groupName: 'dragon',
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

  static const String white = 'assets/images/animal/dragon/white.png';
  static const String wood = 'assets/images/animal/dragon/wood.png';
  static const String fire = 'assets/images/animal/dragon/fire.png';
  static const String earth = 'assets/images/animal/dragon/earth.png';
  static const String metal = 'assets/images/animal/dragon/metal.png';
  static const String water = 'assets/images/animal/dragon/water.png';
}

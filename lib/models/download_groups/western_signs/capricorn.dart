import 'package:ass_downloader_example/models/asset_group.dart';

class CapricornAssetGroup extends ImageAssetGroup {
  CapricornAssetGroup(String domain)
      : super(
          groupName: 'capricorn',
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

  static const String white = 'assets/images/animal/capricorn/white.png';
  static const String wood = 'assets/images/animal/capricorn/wood.png';
  static const String fire = 'assets/images/animal/capricorn/fire.png';
  static const String earth = 'assets/images/animal/capricorn/earth.png';
  static const String metal = 'assets/images/animal/capricorn/metal.png';
  static const String water = 'assets/images/animal/capricorn/water.png';
}

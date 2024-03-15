import 'package:ass_downloader_example/models/asset_group.dart';

class TaurusAssetGroup extends ImageAssetGroup {
  TaurusAssetGroup(String domain)
      : super(
          groupName: 'taurus',
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

  static const String white = 'assets/images/animal/taurus/white.png';
  static const String wood = 'assets/images/animal/taurus/wood.png';
  static const String fire = 'assets/images/animal/taurus/fire.png';
  static const String earth = 'assets/images/animal/taurus/earth.png';
  static const String metal = 'assets/images/animal/taurus/metal.png';
  static const String water = 'assets/images/animal/taurus/water.png';
}

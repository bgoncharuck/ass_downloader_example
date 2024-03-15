import 'package:ass_downloader_example/models/asset_group.dart';

class VirgoAssetGroup extends ImageAssetGroup {
  VirgoAssetGroup(String domain)
      : super(
          groupName: 'virgo',
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

  static const String white = 'assets/images/animal/virgo/white.png';
  static const String wood = 'assets/images/animal/virgo/wood.png';
  static const String fire = 'assets/images/animal/virgo/fire.png';
  static const String earth = 'assets/images/animal/virgo/earth.png';
  static const String metal = 'assets/images/animal/virgo/metal.png';
  static const String water = 'assets/images/animal/virgo/water.png';
}

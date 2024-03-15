import 'package:ass_downloader_example/models/asset_group.dart';

class CancerAssetGroup extends ImageAssetGroup {
  CancerAssetGroup(String domain)
      : super(
          groupName: 'cancer',
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

  static const String white = 'assets/images/animal/cancer/white.png';
  static const String wood = 'assets/images/animal/cancer/wood.png';
  static const String fire = 'assets/images/animal/cancer/fire.png';
  static const String earth = 'assets/images/animal/cancer/earth.png';
  static const String metal = 'assets/images/animal/cancer/metal.png';
  static const String water = 'assets/images/animal/cancer/water.png';
}

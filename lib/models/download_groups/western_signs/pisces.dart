import 'package:ass_downloader_example/models/asset_group.dart';

class PiscesAssetGroup extends ImageAssetGroup {
  PiscesAssetGroup(String domain)
      : super(
          groupName: 'pisces',
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

  static const String white = 'assets/images/animal/pisces/white.png';
  static const String wood = 'assets/images/animal/pisces/wood.png';
  static const String fire = 'assets/images/animal/pisces/fire.png';
  static const String earth = 'assets/images/animal/pisces/earth.png';
  static const String metal = 'assets/images/animal/pisces/metal.png';
  static const String water = 'assets/images/animal/pisces/water.png';
}

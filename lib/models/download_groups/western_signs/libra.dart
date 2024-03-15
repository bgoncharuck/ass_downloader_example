import 'package:ass_downloader_example/models/asset_group.dart';

class LibraAssetGroup extends ImageAssetGroup {
  LibraAssetGroup(String domain)
      : super(
          groupName: 'libra',
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

  static const String white = 'assets/images/animal/libra/white.png';
  static const String wood = 'assets/images/animal/libra/wood.png';
  static const String fire = 'assets/images/animal/libra/fire.png';
  static const String earth = 'assets/images/animal/libra/earth.png';
  static const String metal = 'assets/images/animal/libra/metal.png';
  static const String water = 'assets/images/animal/libra/water.png';
}

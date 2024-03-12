import 'package:ass_downloader_example/models/asset_group.dart';

class RatAssetGroup extends ImageAssetGroup {
  RatAssetGroup(String domain)
      : super(
          groupName: 'rat',
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

  static const String white = 'assets/images/animal/rat/white.png';
  static const String wood = 'assets/images/animal/rat/wood.png';
  static const String fire = 'assets/images/animal/rat/fire.png';
  static const String earth = 'assets/images/animal/rat/earth.png';
  static const String metal = 'assets/images/animal/rat/metal.png';
  static const String water = 'assets/images/animal/rat/water.png';
}

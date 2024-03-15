import 'package:ass_downloader_example/models/asset_group.dart';

class LeoAssetGroup extends ImageAssetGroup {
  LeoAssetGroup(String domain)
      : super(
          groupName: 'leo',
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

  static const String white = 'assets/images/animal/leo/white.png';
  static const String wood = 'assets/images/animal/leo/wood.png';
  static const String fire = 'assets/images/animal/leo/fire.png';
  static const String earth = 'assets/images/animal/leo/earth.png';
  static const String metal = 'assets/images/animal/leo/metal.png';
  static const String water = 'assets/images/animal/leo/water.png';
}

import 'package:ass_downloader_example/models/asset_group.dart';

class TigerAssetGroup extends ImageAssetGroup {
  TigerAssetGroup(String domain)
      : super(
          groupName: 'tiger',
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

  static const String white = 'assets/images/animal/tiger/white.png';
  static const String wood = 'assets/images/animal/tiger/wood.png';
  static const String fire = 'assets/images/animal/tiger/fire.png';
  static const String earth = 'assets/images/animal/tiger/earth.png';
  static const String metal = 'assets/images/animal/tiger/metal.png';
  static const String water = 'assets/images/animal/tiger/water.png';
}

import 'package:ass_downloader_example/models/asset_group.dart';

class MonkeyAssetGroup extends ImageAssetGroup {
  MonkeyAssetGroup(String domain)
      : super(
          groupName: 'monkey',
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

  static const String white = 'assets/images/animal/monkey/white.png';
  static const String wood = 'assets/images/animal/monkey/wood.png';
  static const String fire = 'assets/images/animal/monkey/fire.png';
  static const String earth = 'assets/images/animal/monkey/earth.png';
  static const String metal = 'assets/images/animal/monkey/metal.png';
  static const String water = 'assets/images/animal/monkey/water.png';
}

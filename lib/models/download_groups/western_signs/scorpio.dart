import 'package:ass_downloader_example/models/asset_group.dart';

class ScorpioAssetGroup extends ImageAssetGroup {
  ScorpioAssetGroup(String domain)
      : super(
          groupName: 'scorpio',
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

  static const String white = 'assets/images/animal/scorpio/white.png';
  static const String wood = 'assets/images/animal/scorpio/wood.png';
  static const String fire = 'assets/images/animal/scorpio/fire.png';
  static const String earth = 'assets/images/animal/scorpio/earth.png';
  static const String metal = 'assets/images/animal/scorpio/metal.png';
  static const String water = 'assets/images/animal/scorpio/water.png';
}

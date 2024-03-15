import 'package:ass_downloader_example/models/asset_group.dart';

class AriesAssetGroup extends ImageAssetGroup {
  AriesAssetGroup(String domain)
      : super(
          groupName: 'aries',
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

  static const String white = 'assets/images/animal/aries/white.png';
  static const String wood = 'assets/images/animal/aries/wood.png';
  static const String fire = 'assets/images/animal/aries/fire.png';
  static const String earth = 'assets/images/animal/aries/earth.png';
  static const String metal = 'assets/images/animal/aries/metal.png';
  static const String water = 'assets/images/animal/aries/water.png';
}

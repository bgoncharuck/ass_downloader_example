import 'package:ass_downloader_example/models/asset_group.dart';

class RabbitAssetGroup extends ImageAssetGroup {
  RabbitAssetGroup(String domain)
      : super(
          groupName: 'rabbit',
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

  static const String white = 'assets/images/animal/rabbit/white.png';
  static const String wood = 'assets/images/animal/rabbit/wood.png';
  static const String fire = 'assets/images/animal/rabbit/fire.png';
  static const String earth = 'assets/images/animal/rabbit/earth.png';
  static const String metal = 'assets/images/animal/rabbit/metal.png';
  static const String water = 'assets/images/animal/rabbit/water.png';
}

import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class SnakeAssetGroup extends ImageAssetGroup {
  SnakeAssetGroup()
      : super(
          groupName: 'snake',
          baseUrl: env['DOMAIN_URL'],
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

  static const String white = 'assets/images/animal/snake/white.png';
  static const String wood = 'assets/images/animal/snake/wood.png';
  static const String fire = 'assets/images/animal/snake/fire.png';
  static const String earth = 'assets/images/animal/snake/earth.png';
  static const String metal = 'assets/images/animal/snake/metal.png';
  static const String water = 'assets/images/animal/snake/water.png';
}

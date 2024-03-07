import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class PigAssetGroup extends DefaultAssetGroup {
  PigAssetGroup()
      : super(
          groupName: 'pig',
          baseUrl: env['DOMAIN_URL'],
          assets: [
            white,
            wood,
            fire,
            earth,
            metal,
            water,
          ],
        );

  static const String white = 'assets/images/animal/pig/white.png';
  static const String wood = 'assets/images/animal/pig/wood.png';
  static const String fire = 'assets/images/animal/pig/fire.png';
  static const String earth = 'assets/images/animal/pig/earth.png';
  static const String metal = 'assets/images/animal/pig/metal.png';
  static const String water = 'assets/images/animal/pig/water.png';
}

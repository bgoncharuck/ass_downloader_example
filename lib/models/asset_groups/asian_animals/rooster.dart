import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class RoosterAssetGroup extends ImageAssetGroup {
  RoosterAssetGroup()
      : super(
          groupName: 'rooster',
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

  static const String white = 'assets/images/animal/rooster/white.png';
  static const String wood = 'assets/images/animal/rooster/wood.png';
  static const String fire = 'assets/images/animal/rooster/fire.png';
  static const String earth = 'assets/images/animal/rooster/earth.png';
  static const String metal = 'assets/images/animal/rooster/metal.png';
  static const String water = 'assets/images/animal/rooster/water.png';
}

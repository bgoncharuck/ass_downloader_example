import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class OxAssetGroup extends ImageAssetGroup {
  OxAssetGroup()
      : super(
          groupName: 'ox',
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

  static const String white = 'assets/images/animal/ox/white.png';
  static const String wood = 'assets/images/animal/ox/wood.png';
  static const String fire = 'assets/images/animal/ox/fire.png';
  static const String earth = 'assets/images/animal/ox/earth.png';
  static const String metal = 'assets/images/animal/ox/metal.png';
  static const String water = 'assets/images/animal/ox/water.png';
}

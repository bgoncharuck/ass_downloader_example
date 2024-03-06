import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class TigerAssetGroup extends DefaultAssetGroup {
  TigerAssetGroup()
      : super(
          groupName: 'Tiger images Download Scenario',
          baseUrl: '${env['DOMAIN_URL']}/assets/images/animal/tiger',
          assets: [
            white,
            wood,
            fire,
            earth,
            metal,
            water,
          ],
        );

  static const String white = 'white.png';
  static const String wood = 'wood.png';
  static const String fire = 'fire.png';
  static const String earth = 'earth.png';
  static const String metal = 'metal.png';
  static const String water = 'water.png';
}

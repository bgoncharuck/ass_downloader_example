import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class HorseAssetGroup extends DefaultAssetGroup {
  HorseAssetGroup()
      : super(
          groupName: 'horse',
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

  static const String white = 'assets/images/animal/horse/white.png';
  static const String wood = 'assets/images/animal/horse/wood.png';
  static const String fire = 'assets/images/animal/horse/fire.png';
  static const String earth = 'assets/images/animal/horse/earth.png';
  static const String metal = 'assets/images/animal/horse/metal.png';
  static const String water = 'assets/images/animal/horse/water.png';
}

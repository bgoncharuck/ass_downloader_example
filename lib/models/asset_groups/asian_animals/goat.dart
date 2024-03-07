import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/models/asset_group.dart';

class GoatAssetGroup extends DefaultAssetGroup {
  GoatAssetGroup()
      : super(
          groupName: 'goat',
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

  static const String white = 'assets/images/animal/goat/white.png';
  static const String wood = 'assets/images/animal/goat/wood.png';
  static const String fire = 'assets/images/animal/goat/fire.png';
  static const String earth = 'assets/images/animal/goat/earth.png';
  static const String metal = 'assets/images/animal/goat/metal.png';
  static const String water = 'assets/images/animal/goat/water.png';
}

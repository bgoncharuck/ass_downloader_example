import 'package:ass_downloader_example/models/asset_group.dart';

class DogAssetGroup extends ImageAssetGroup {
  DogAssetGroup(String domain)
      : super(
          groupName: 'dog',
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

  static const String white = 'assets/images/animal/dog/white.png';
  static const String wood = 'assets/images/animal/dog/wood.png';
  static const String fire = 'assets/images/animal/dog/fire.png';
  static const String earth = 'assets/images/animal/dog/earth.png';
  static const String metal = 'assets/images/animal/dog/metal.png';
  static const String water = 'assets/images/animal/dog/water.png';
}

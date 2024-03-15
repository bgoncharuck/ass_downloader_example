import 'package:ass_downloader_example/models/asset_group.dart';

class SagittariusAssetGroup extends ImageAssetGroup {
  SagittariusAssetGroup(String domain)
      : super(
          groupName: 'sagittarius',
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

  static const String white = 'assets/images/animal/sagittarius/white.png';
  static const String wood = 'assets/images/animal/sagittarius/wood.png';
  static const String fire = 'assets/images/animal/sagittarius/fire.png';
  static const String earth = 'assets/images/animal/sagittarius/earth.png';
  static const String metal = 'assets/images/animal/sagittarius/metal.png';
  static const String water = 'assets/images/animal/sagittarius/water.png';
}

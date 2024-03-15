import 'package:ass_downloader_example/models/asset_group.dart';

class GeminiAssetGroup extends ImageAssetGroup {
  GeminiAssetGroup(String domain)
      : super(
          groupName: 'gemini',
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

  static const String white = 'assets/images/animal/gemini/white.png';
  static const String wood = 'assets/images/animal/gemini/wood.png';
  static const String fire = 'assets/images/animal/gemini/fire.png';
  static const String earth = 'assets/images/animal/gemini/earth.png';
  static const String metal = 'assets/images/animal/gemini/metal.png';
  static const String water = 'assets/images/animal/gemini/water.png';
}

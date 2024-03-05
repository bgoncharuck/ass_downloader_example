import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:flutter/widgets.dart';

class AssetGroupScreenController extends ScreenController {
  AssetGroupScreenController({required this.assetGroupName});
  final String assetGroupName;

  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathAnimals,
    );
  }
}

class AssetGroupScreenLocator extends InheritedWidget {
  const AssetGroupScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final AssetGroupScreenController controller;

  static AssetGroupScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<AssetGroupScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'AssetGroupScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

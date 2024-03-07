import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:flutter/widgets.dart';

class AssetGroupViewScreenController extends ScreenController {
  AssetGroupViewScreenController({
    required this.fromAssetGroups,
    required this.assetGroupName,
  });

  final Map<String, AssetGroup> fromAssetGroups;
  final String assetGroupName;

  AssetGroup get aGroup => fromAssetGroups[assetGroupName]!;

  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathGroups,
      arguments: fromAssetGroups,
    );
  }
}

class AssetGroupViewScreenLocator extends InheritedWidget {
  const AssetGroupViewScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final AssetGroupViewScreenController controller;

  static AssetGroupViewScreenController of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<AssetGroupViewScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'AssetGroupViewScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

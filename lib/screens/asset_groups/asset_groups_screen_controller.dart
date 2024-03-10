import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:flutter/widgets.dart';

class AssetGroupsScreenController extends ScreenController {
  AssetGroupsScreenController({required this.assetGroups});

  final Map<String, AssetGroup> assetGroups;

  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathMenu,
    );
  }

  void selectAssetGroup(BuildContext context, String assetGroupName) {
    Navigator.of(context).pushNamed(
      pathGroup,
      arguments: [
        assetGroups,
        assetGroupName,
      ],
    );
  }
}

class AssetGroupsScreenLocator extends InheritedWidget {
  const AssetGroupsScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final AssetGroupsScreenController controller;

  static AssetGroupsScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<AssetGroupsScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'AssetGroupsScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

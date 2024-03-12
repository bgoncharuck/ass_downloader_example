import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/download_group.dart';
import 'package:flutter/widgets.dart';

class MenuScreenController extends ScreenController {
  MenuScreenController(this.downloadGroups);
  final Map<String, DownloadGroup> downloadGroups;

  void selectAssetGroups(BuildContext context, String assetGroupsName) {
    //
    Navigator.of(context).pushNamed(
      pathGroups,
      arguments: downloadGroups[assetGroupsName],
    );
  }
}

class MenuScreenLocator extends InheritedWidget {
  const MenuScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final MenuScreenController controller;

  static MenuScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<MenuScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'MenuScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

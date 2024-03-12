import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download_group.dart';
import 'package:ass_downloader_example/models/download_groups/download_groups.dart';
import 'package:flutter/widgets.dart';

class DownloadGroupScreenController extends ScreenController {
  DownloadGroupScreenController({required this.downloadGroup});

  final DownloadGroup downloadGroup;
  Map<String, AssetGroup> get assetGroups => downloadGroup.assets;

  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathMenu,
      arguments: downloadGroups,
    );
  }

  void selectAssetGroup(BuildContext context, String assetGroupName) {
    Navigator.of(context).pushNamed(
      pathGroup,
      arguments: [
        downloadGroup,
        assetGroupName,
      ],
    );
  }
}

class DownloadGroupScreenLocator extends InheritedWidget {
  const DownloadGroupScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final DownloadGroupScreenController controller;

  static DownloadGroupScreenController of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<DownloadGroupScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'DownloadGroupScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

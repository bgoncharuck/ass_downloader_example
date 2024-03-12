import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/asset_group.dart';
import 'package:ass_downloader_example/models/download_group.dart';
import 'package:flutter/widgets.dart';

class ImageAssetGroupViewScreenController extends ScreenController {
  ImageAssetGroupViewScreenController({
    required this.fromDownloadGroup,
    required this.assetGroupName,
  });

  final DownloadGroup fromDownloadGroup;
  final String assetGroupName;

  ImageAssetGroup get aGroup =>
      fromDownloadGroup.assets[assetGroupName]! as ImageAssetGroup;

  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathGroups,
      arguments: fromDownloadGroup,
    );
  }
}

class ImageAssetGroupViewScreenLocator extends InheritedWidget {
  const ImageAssetGroupViewScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final ImageAssetGroupViewScreenController controller;

  static ImageAssetGroupViewScreenController of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<ImageAssetGroupViewScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'ImageAssetGroupViewScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

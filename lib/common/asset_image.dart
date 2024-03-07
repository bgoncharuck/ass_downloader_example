import 'dart:io';
import 'package:ass_downloader_example/services/assets_manager/assets_manager.dart';
import 'package:flutter/widgets.dart';

class AssetImage extends StatefulWidget {
  /// Precaches given asset and just returns ```Image``` as it is
  const AssetImage(
    this.asset, {
    this.width,
    this.height,
    this.fit = BoxFit.fitWidth,
    super.key,
  });
  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  State<AssetImage> createState() => _AssetImageState();
}

class _AssetImageState extends State<AssetImage> {
  late final Image cachedImage;

  @override
  void initState() {
    super.initState();

    final path = assetsManager.getAssetPath(widget.asset);
    if (path == null) {
      cachedImage = Image.asset(
        'assets/no_image.png',
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    } else {
      cachedImage = Image.file(
        File(path),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(cachedImage.image, context);
  }

  @override
  Widget build(BuildContext context) => cachedImage;
}

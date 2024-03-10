import 'package:ass_downloader_example/common/cached_asset_image.dart';
import 'package:ass_downloader_example/screens/Image_asset_group_view/image_asset_group_view_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class ImageAssetGroupViewScreen extends StatelessWidget {
  const ImageAssetGroupViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenController = ImageAssetGroupViewScreenLocator.of(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(screenController.assetGroupName),
                leading: CupertinoNavigationBarBackButton(
                  onPressed: () => screenController.back(context),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 34,
                ),
              ),
              SliverGrid.builder(
                itemCount: screenController.aGroup.assets.length,
                itemBuilder: (_, index) {
                  final asset = screenController.aGroup.assets.elementAt(index);

                  return CachedAssetImage(
                    asset,
                    width: screenController.aGroup.width,
                    height: screenController.aGroup.height,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ass_downloader_example/screens/download_group/download_group_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class DownloadGroupScreen extends StatelessWidget {
  const DownloadGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenController = DownloadGroupScreenLocator.of(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(screenController.downloadGroup.name),
                leading: CupertinoNavigationBarBackButton(
                  onPressed: () => screenController.back(context),
                ),
              ),
              SliverList.builder(
                itemCount: screenController.assetGroups.length,
                itemBuilder: (_, index) {
                  final groupKey =
                      screenController.assetGroups.keys.elementAt(index);

                  return CupertinoButton(
                    child: Text(groupKey),
                    onPressed: () =>
                        screenController.selectAssetGroup(context, groupKey),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

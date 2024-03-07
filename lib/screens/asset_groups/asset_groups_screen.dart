import 'package:ass_downloader_example/screens/asset_groups/asset_groups_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class AssetGroupsScreen extends StatelessWidget {
  const AssetGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenController = AssetGroupsScreenLocator.of(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Asset Groups View'),
                leading: CupertinoNavigationBarBackButton(
                  onPressed: () => screenController.back(context),
                ),
              ),
              SliverList.builder(
                itemCount: screenController.assetGroupNames.length,
                itemBuilder: (_, index) {
                  final groupKey =
                      screenController.assetGroupNames.elementAt(index);

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
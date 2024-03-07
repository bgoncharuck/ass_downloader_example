import 'package:ass_downloader_example/screens/asset_group_view/asset_group_view_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class AssetGroupViewScreen extends StatelessWidget {
  const AssetGroupViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () =>
                  AssetGroupViewScreenLocator.of(context).back(context),
            ),
            middle:
                Text(AssetGroupViewScreenLocator.of(context).assetGroupName),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ass_downloader_example/screens/asset_groups/asset_groups_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class AssetGroupsScreen extends StatelessWidget {
  const AssetGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () =>
                  AssetGroupsScreenLocator.of(context).back(context),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: const Text('Horse'),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/animal',
                    arguments: 'horse',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

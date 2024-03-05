import 'package:ass_downloader_example/screens/animal/animal_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class AssetGroupScreen extends StatelessWidget {
  const AssetGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () =>
                  AssetGroupScreenLocator.of(context).back(context),
            ),
            middle: Text(AssetGroupScreenLocator.of(context).assetGroupName),
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

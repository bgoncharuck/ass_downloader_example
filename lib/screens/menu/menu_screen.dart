import 'package:ass_downloader_example/models/asset_groups/asian_animals/asian_animals.dart';
import 'package:ass_downloader_example/screens/menu/menu_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MenuScreenLocator.of(context).init();
  }

  @override
  Widget build(BuildContext context) {
    final screenController = MenuScreenLocator.of(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList.builder(
                itemCount: screenController.assetGroups.length,
                itemBuilder: (_, index) {
                  final groupKey =
                      screenController.assetGroups.keys.elementAt(index);

                  return CupertinoButton(
                    child: Text(groupKey),
                    onPressed: () =>
                        screenController.selectAssetGroups(context, groupKey),
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

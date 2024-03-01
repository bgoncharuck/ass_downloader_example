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
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: const Text('Animals'),
                  onPressed: () => Navigator.pushNamed(context, '/animals'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

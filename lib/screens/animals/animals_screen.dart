import 'package:ass_downloader_example/screens/animals/animals_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class AnimalsScreen extends StatelessWidget {
  const AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => AnimalsScreenLocator.of(context).back(context),
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

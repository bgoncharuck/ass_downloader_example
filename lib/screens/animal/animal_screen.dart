import 'package:ass_downloader_example/screens/animal/animal_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class AnimalScreen extends StatelessWidget {
  const AnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => AnimalScreenLocator.of(context).back(context),
            ),
            middle: Text(AnimalScreenLocator.of(context).animal),
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

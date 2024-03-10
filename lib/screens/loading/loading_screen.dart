// import 'package:ass_downloader_example/screens/loading/loading_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenController = LoadingScreenLocator.of(context);

    return const PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: Stack(
            children: [
              Align(
                child: Text('Loading App Assets...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

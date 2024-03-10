import 'package:ass_downloader_example/screens/loading/loading_screen_controller.dart';
import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      LoadingScreenLocator.of(context).init();
    }
  }

  @override
  Widget build(BuildContext context) {
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

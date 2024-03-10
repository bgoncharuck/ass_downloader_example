import 'package:ass_downloader_example/screens/error/error_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenController = ErrorScreenLocator.of(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Text(screenController.errorMessage),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                  child: CupertinoButton(
                    onPressed: screenController.action,
                    child: const Text('Try Again'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

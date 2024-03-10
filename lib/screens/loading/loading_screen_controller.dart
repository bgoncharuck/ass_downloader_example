import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:flutter/widgets.dart';

class LoadingScreenController extends ScreenController {
  LoadingScreenController();
}

class LoadingScreenLocator extends InheritedWidget {
  const LoadingScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final LoadingScreenController controller;

  static LoadingScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<LoadingScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'LoadingScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:flutter/widgets.dart';

class ErrorScreenController extends ScreenController {
  ErrorScreenController({
    required this.errorMessage,
    required this.action,
  });

  final String errorMessage;
  final void Function() action;
}

class ErrorScreenLocator extends InheritedWidget {
  const ErrorScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final ErrorScreenController controller;

  static ErrorScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<ErrorScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'ErrorScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

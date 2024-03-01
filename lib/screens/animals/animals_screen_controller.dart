import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:flutter/widgets.dart';

class AnimalsScreenController extends ScreenController {
  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathMenu,
    );
  }
}

class AnimalsScreenLocator extends InheritedWidget {
  const AnimalsScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final AnimalsScreenController controller;

  static AnimalsScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<AnimalsScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'AnimalsScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

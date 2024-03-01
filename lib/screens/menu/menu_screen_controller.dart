import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/use_case/presentation/remove_native_splash.dart';
import 'package:flutter/widgets.dart';

class MenuScreenController extends ScreenController {
  void init() {
    if (super.initOnce) {
      return;
    }
    const RemoveNativeSplash().execute();
  }
}

class MenuScreenLocator extends InheritedWidget {
  const MenuScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final MenuScreenController controller;

  static MenuScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<MenuScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'MenuScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

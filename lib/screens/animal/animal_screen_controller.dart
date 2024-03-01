import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:flutter/widgets.dart';

class AnimalScreenController extends ScreenController {
  AnimalScreenController({required this.animal});
  final String animal;

  void back(BuildContext context) {
    Navigator.of(context).pushNamed(
      pathAnimals,
    );
  }
}

class AnimalScreenLocator extends InheritedWidget {
  const AnimalScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final AnimalScreenController controller;

  static AnimalScreenController of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<AnimalScreenLocator>();
    if (widget == null) {
      throw FlutterError(
        'AnimalScreenLocator not found in context.',
      );
    }
    return widget.controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

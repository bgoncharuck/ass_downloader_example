import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/download/status/download_status.dart';
import 'package:ass_downloader_example/use_case/domain/sync_assets.dart';
import 'package:ass_downloader_example/use_case/presentation/remove_native_splash.dart';
import 'package:flutter/widgets.dart';

class LoadingScreenController extends ScreenController {
  LoadingScreenController();
  late BuildContext context;

  Future<void> init(BuildContext context) async {
    this.context = context;
    await loadAppAssets();

    if (super.initOnce) {
      return;
    }
    await const RemoveNativeSplash().execute();
  }

  Future<void> loadAppAssets() async {
    final resultOfSync = await const SyncAssets().execute();
    if (resultOfSync is DownloadError) {
      onError('Unknown Error during downloading assets');
    } else {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushReplacementNamed(
        pathMenu,
      );
    }
  }

  void onError(String message) {
    Navigator.of(context).pushReplacementNamed(
      pathError,
      arguments: [
        message,
        () {
          Navigator.of(context).pushReplacementNamed(
            pathLoading,
          );
        },
      ],
    );
  }
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

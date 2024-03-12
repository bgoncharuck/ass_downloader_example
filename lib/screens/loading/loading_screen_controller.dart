import 'package:ass_downloader_example/app/routes.dart';
import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/models/download_groups/asian_animals/asian_animals.dart';
import 'package:ass_downloader_example/models/download_groups/download_groups.dart';
import 'package:ass_downloader_example/models/download/status/download_errors.dart';
import 'package:ass_downloader_example/models/download/status/download_status.dart';
import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:ass_downloader_example/use_case/domain/sync_assets.dart';
import 'package:ass_downloader_example/use_case/presentation/remove_native_splash.dart';
import 'package:flutter/widgets.dart';

class LoadingScreenController extends ScreenController {
  LoadingScreenController();

  void init() {
    if (super.initOnce) {
      return;
    }
    const RemoveNativeSplash().execute();
  }

  Future<void> loadAppAssets() async {
    try {
      final resultOfSync = await const SyncAssets().execute();
      //
      if (resultOfSync.status.isError) {
        handleError(resultOfSync.status);
      } else {
        await navigatorKey.currentState!.pushReplacementNamed(
          pathMenu,
          arguments: downloadGroups,
        );
      }
    } catch (e, t) {
      await log.exception(e, t);
    }
  }

  void handleError(DownloadStatus status) {
    if (status is NoUrlsProvidedInAssetGroupError) {
      onError(
        'During executing download tasks no domains were provided, '
        'contact the developer',
      );
    } else if (status is DomainsNotReachableError) {
      onError(
        'During executing download tasks some domains were not reachable: '
        '${status.domains.join(', ')}',
      );
    } else if (status is NoFilesWereDownloadedSuccessfullyError) {
      onError(
        'No files were downloaded successfully',
      );
    } else if (status is SomeFilesWereNotDownloadedError) {
      onError(
        'Some files were not downloaded successfully: '
        '${status.urls.join(', ')}',
      );
    } else {
      onError('Unknown Error during downloading assets');
    }
  }

  void onError(String message) {
    navigatorKey.currentState!.pushReplacementNamed(
      pathError,
      arguments: [
        message,
        () {
          navigatorKey.currentState!.pushReplacementNamed(
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

import 'package:ass_downloader_example/config/app/routines/crash_watcher.dart';
import 'package:ass_downloader_example/config/env/init.dart';
import 'package:ass_downloader_example/config/widgets_binding/config.dart';
import 'package:ass_downloader_example/services/logger/init.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

/// params is `runApp` function
class InitializeApp with IUseCase<void Function(), void> {
  @override
  Future<void> execute({required void Function() params}) async {
    await ConfigWidgetsBinding().execute();
    await InitializeEnvironment().execute(
      params: [
        'DOMAIN_URL',
        'SENTRY_DSN',
      ],
    );
    await InitializeLogger().execute();

    await SetCrashWatcherOverAppRunner().execute(
      params: params,
    );
  }
}

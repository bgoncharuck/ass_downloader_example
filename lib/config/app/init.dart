import 'package:ass_downloader_example/config/app/routines/crash_watcher.dart';
import 'package:ass_downloader_example/config/env/init.dart';
import 'package:ass_downloader_example/config/widgets_binding/config.dart';
import 'package:ass_downloader_example/services/logger/init.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

/// params is `runApp` function
class InitializeApp with IUseCase<void Function(), void> {
  const InitializeApp();

  @override
  Future<void> execute({required void Function() params}) async {
    await const ConfigWidgetsBinding().execute();
    await const InitializeEnvironment().execute(
      params: [
        'DOMAIN_URL',
        'SENTRY_DSN',
      ],
    );
    await const InitializeLogger().execute();

    await const SetCrashWatcherOverAppRunner().execute(
      params: params,
    );
  }
}

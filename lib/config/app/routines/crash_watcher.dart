import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SetCrashWatcherOverAppRunner with IUseCase<void Function(), void> {
  const SetCrashWatcherOverAppRunner();

  @override
  Future<void> execute({required void Function() params}) async {
    await SentryFlutter.init(
      _sentryOptions,
      appRunner: () async => params(),
    );
  }
}

void _sentryOptions(SentryFlutterOptions options) {
  options
    ..dsn = env['SENTRY_DSN']
    ..tracesSampleRate = 1.0
    ..sendDefaultPii = true
    ..attachScreenshot = false
    ..attachStacktrace = true;
}

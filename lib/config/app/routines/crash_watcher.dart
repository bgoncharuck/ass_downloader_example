import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SetCrashWatcherOverAppRunner
    with IUseCase<Future<void> Function(), void> {
  @override
  Future<void> execute({required Future<void> Function() params}) async {
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

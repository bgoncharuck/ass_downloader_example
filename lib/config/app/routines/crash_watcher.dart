import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SetCrashWatcherOverAppRunner with IUseCase<void Function(), void> {
  const SetCrashWatcherOverAppRunner();

  /// params: A function to be executed as the main application runner.
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
    ..dsn = env['SENTRY_DSN'] // Set the Sentry DSN from environment variables.
    ..tracesSampleRate =
        1.0 // Set the sampling rate for performance traces to 100%.
    ..sendDefaultPii =
        true // Enable sending default personally identifiable information.
    ..attachScreenshot = false // Disable attaching screenshots to events.
    ..attachStacktrace = true; // Enable attaching stack traces to events.
}

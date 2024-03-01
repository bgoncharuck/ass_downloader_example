import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLogging implements LoggingLibrary {
  const SentryLogging();

  @override
  Future<void> exception(Object e, StackTrace t) async =>
      Sentry.captureException(e, stackTrace: t);
  @override
  Future<void> message(String message) async => Sentry.captureMessage(message);
}

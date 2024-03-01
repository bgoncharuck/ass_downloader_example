import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:ass_downloader_example/services/logger/plugins/debug_print.dart';
import 'package:ass_downloader_example/services/logger/plugins/sentry_flutter.dart';
import 'package:flutter/foundation.dart';

class MultipleLibrariesLogging implements LoggingLibrary {
  final Iterable<LoggingLibrary> libraries = [
    const SentryLogging(),
    if (kDebugMode) const DebugPrintLogging(),
  ];

  @override
  Future<void> exception(Object e, StackTrace t) async {
    for (final lib in libraries) {
      await lib.exception(e, t);
    }
  }

  @override
  Future<void> message(String message) async {
    for (final lib in libraries) {
      await lib.message(message);
    }
  }
}

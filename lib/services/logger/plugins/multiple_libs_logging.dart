import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:ass_downloader_example/services/logger/plugins/debug_print.dart';
import 'package:ass_downloader_example/services/logger/plugins/sentry_flutter.dart';
import 'package:flutter/foundation.dart';

/// A logging implementation that aggregates logging from multiple logging libraries.
class MultipleLibrariesLogging implements LoggingLibrary {
  /// The list of logging libraries to be used.
  final Iterable<LoggingLibrary> libraries = [
    const SentryLogging(),
    // Initialize DebugPrintLogging for logging messages during debug mode.
    if (kDebugMode) const DebugPrintLogging(),
  ];

  /// Logs an exception to all configured logging libraries.
  ///
  /// This method propagates the given [e] (exception) and [t] (stack trace)
  /// to all logging libraries registered in [libraries].
  @override
  Future<void> exception(Object e, StackTrace t) async {
    for (final lib in libraries) {
      await lib.exception(e, t);
    }
  }

  /// Logs a message to all configured logging libraries.
  ///
  /// This method propagates the given [message] to all logging libraries
  /// registered in [libraries].
  @override
  Future<void> message(String message) async {
    for (final lib in libraries) {
      await lib.message(message);
    }
  }
}

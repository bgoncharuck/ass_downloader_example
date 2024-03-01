import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:flutter/foundation.dart';

class DebugPrintLogging implements LoggingLibrary {
  const DebugPrintLogging();

  @override
  Future<void> exception(Object e, StackTrace t) async => debugPrint('''
\n\nException $e\nstackTrace:\n$t\n\n
    ''');
  @override
  Future<void> message(String message) async => debugPrint(message);
}

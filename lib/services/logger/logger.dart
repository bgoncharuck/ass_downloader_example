late final LoggingLibrary log;

abstract class LoggingLibrary {
  Future<void> exception(Object e, StackTrace t);
  Future<void> message(String message);
}

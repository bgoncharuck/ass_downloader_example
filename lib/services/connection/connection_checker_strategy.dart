/// returns available domains sorted by ping time
// ignore: one_member_abstracts
abstract class ConnectionCheckerStrategy {
  /// Returns a list of available domains sorted by ping time.
  ///
  /// Given a list of URLs, this method checks the connection status of each URL
  /// asynchronously and returns a list of available domains sorted by ping time
  Future<List<String>> isConnected(List<String> urls);
}

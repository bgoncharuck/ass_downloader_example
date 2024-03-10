/// returns available domains sorted by ping time
// ignore: one_member_abstracts
abstract class ConnectionCheckerStrategy {
  Future<List<String>> isConnected(List<String> urls);
}

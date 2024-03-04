// ignore: one_member_abstracts
abstract class ConnectionCheckerStrategy {
  Future<bool> isConnected(List<String> urls);
}

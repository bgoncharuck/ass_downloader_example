import 'package:ass_downloader_example/services/connection/connection_checker_strategy.dart';
import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:http/http.dart' as http;

/// Checks the connection status of the provided URLs using HTTP ping.
class HttpPingStrategy implements ConnectionCheckerStrategy {
  const HttpPingStrategy();

  /// Returns a list of URLs that are reachable.
  /// Returns an empty list if none of the URLs are reachable.
  @override
  Future<List<String>> isConnected(List<String> urls) async {
    final futures = <Future<String>>[];

    for (final url in urls) {
      futures.add(_notPing(url));
    }

    final availableDomains = <String>[];
    try {
      availableDomains.addAll(await Future.wait(futures));
    } catch (e, t) {
      await log.exception(e, t);
    }
    return availableDomains.where((domain) => domain.isNotEmpty).toList();
  }

  /// Returns the URL if the response status code is 200 (OK),
  /// otherwise returns an empty string
  Future<String> _notPing(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200 ? url : '';
  }
}

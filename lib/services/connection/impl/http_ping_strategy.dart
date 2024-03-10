import 'package:ass_downloader_example/services/connection/connection_checker_strategy.dart';
import 'package:http/http.dart' as http;

class HttpPingStrategy implements ConnectionCheckerStrategy {
  const HttpPingStrategy();

  @override
  Future<List<String>> isConnected(List<String> urls) async {
    final futures = <Future<String>>[];

    for (final url in urls) {
      futures.add(_notPing(url));
    }

    final availableDomains = await Future.wait(futures);

    return availableDomains.where((domain) => domain.isNotEmpty).toList();
  }

  Future<String> _notPing(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200 ? url : '';
  }
}

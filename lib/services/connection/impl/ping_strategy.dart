import 'package:ass_downloader_example/services/connection/connection_checker_strategy.dart';
import 'package:http/http.dart' as http;

class PingStrategy implements ConnectionCheckerStrategy {
  @override
  Future<bool> isConnected(List<String> urls) async {
    for (final url in urls) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          return true;
        }
      } catch (_) {
        continue;
      }
    }

    return false;
  }
}

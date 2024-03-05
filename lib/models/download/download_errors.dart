import 'package:ass_downloader_example/models/download/download_status.dart';

class DomainsNotReachableError extends DownloadError {
  const DomainsNotReachableError(this.domains);

  @override
  String get name => 'domains_not_reachable_error';

  final List<String> domains;
}

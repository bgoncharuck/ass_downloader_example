import 'package:ass_downloader_example/models/download/status/download_status.dart';

class DomainsNotReachableError extends DownloadError {
  const DomainsNotReachableError(this.domains);

  @override
  String get name => 'domains_not_reachable_error';

  final List<String> domains;
}

class NoUrlsProvidedInAssetGroupError extends DownloadError {
  const NoUrlsProvidedInAssetGroupError();

  @override
  String get name => 'no_urls_provided_in_group';
}

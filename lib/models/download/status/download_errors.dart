import 'package:ass_downloader_example/models/download/status/download_status.dart';

class NoUrlsProvidedInAssetGroupError extends DownloadError {
  const NoUrlsProvidedInAssetGroupError();

  @override
  String get name => 'no_urls_provided_in_group';
}

class DomainsNotReachableError extends DownloadError {
  const DomainsNotReachableError(this.domains);

  @override
  String get name => 'domains_not_reachable_error';

  final List<String> domains;
}

class SomeFilesWereNotDownloadedError extends DownloadError {
  const SomeFilesWereNotDownloadedError(this.urls);

  @override
  String get name => 'some_files_not_downloaded';

  final List<String> urls;
}

class NoFilesWereDownloadedSuccessfullyError
    extends SomeFilesWereNotDownloadedError {
  const NoFilesWereDownloadedSuccessfullyError(super.urls);

  @override
  String get name => 'no_files_downloaded_successfully';
}

class DownloadGroupWasNotInitialized extends DownloadError {
  const DownloadGroupWasNotInitialized();

  @override
  String get name => 'download_group_was_not_initialized';
}

class EventLoopOverflowError extends DownloadError {
  const EventLoopOverflowError();

  @override
  String get name => 'event_loop_overflow_error';
}

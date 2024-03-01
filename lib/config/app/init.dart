import 'package:ass_downloader_example/config/env/init.dart';
import 'package:ass_downloader_example/services/logger/init.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

class InitializeApp with IUseCase<void, void> {
  @override
  Future<void> execute({void params}) async {
    await InitializeEnvironment().execute(
      params: [
        'DOMAIN_URL',
        'SENTRY_DSN',
      ],
    );
    await InitializeLogger().execute();
  }
}

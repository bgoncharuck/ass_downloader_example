import 'package:ass_downloader_example/services/logger/logger.dart';
import 'package:ass_downloader_example/services/logger/plugins/multiple_libs_logging.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

class InitializeLogger with IUseCase<void, void> {
  @override
  Future<void> execute({void params}) async {
    log = MultipleLibrariesLogging();
  }
}

import 'package:ass_downloader_example/config/env/init.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

class InitializeApp with IUseCase<void, void> {
  @override
  Future<void> execute({void params}) async {
    InitializeEnvironment().execute(params: []);
  }
}

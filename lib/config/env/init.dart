import 'package:ass_downloader_example/config/env/env.dart';
import 'package:ass_downloader_example/config/env/plugin/flutter_dotenv.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

class InitializeEnvironment with IUseCase<List<String>, bool> {
  @override
  Future<bool> execute({required List<String> params}) async {
    env = DefaultFlutterDotenvWrapper();
    return env.load(params);
  }
}

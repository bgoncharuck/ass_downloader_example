import 'package:ass_downloader_example/config/widgets_binding/widgets_binding.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';

class RemoveNativeSplash with IUseCase<void, void> {
  const RemoveNativeSplash();

  @override
  Future<void> execute({void params}) async {
    widgetsBinding.removeSplashScreen();
  }
}

import 'package:ass_downloader_example/controllers/screen_controller.dart';
import 'package:ass_downloader_example/use_case/presentation/remove_native_splash.dart';

class MenuScreenController extends ScreenController {
  void init() {
    if (super.initOnce) {
      return;
    }
    const RemoveNativeSplash().execute();
  }
}

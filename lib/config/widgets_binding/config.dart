import 'package:ass_downloader_example/config/widgets_binding/widgets_binding.dart';
import 'package:ass_downloader_example/use_case/i_use_case.dart';
import 'package:flutter/widgets.dart';

class ConfigWidgetsBinding with IUseCase<void, void> {
  @override
  Future<void> execute({void params}) async {
    widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    widgetsBinding.preserveSplashScreen();
  }
}

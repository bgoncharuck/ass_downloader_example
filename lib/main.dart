import 'package:ass_downloader_example/app/app.dart';
import 'package:ass_downloader_example/config/app/init.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  await const InitializeApp().execute(
    params: () => runApp(
      const App(),
    ),
  );
}
